<?php 
session_start();
include "../Utils/Util.php";
include "../Utils/Validation.php";

// Check authentication
if (!isset($_SESSION['username']) || !isset($_SESSION['instructor_id'])) {
    Util::redirect("../login.php", "error", "Please login first");
    exit();
}

include "../Controller/Instructor/Course.php";

// Initialize variables
$instructor_id = $_SESSION['instructor_id'];
$title = $description = "";
$courses = getCoursesByInstructorId($instructor_id);

if (!$courses) {
    $courses = [];
}

// Get form values if they exist (for form persistence after error)
if (isset($_GET["title"])) {
    $title = Validation::clean($_GET["title"]);
}
if (isset($_GET["description"])) {
    $description = Validation::clean($_GET["description"]);
}

# Header
$page_title = "VuLearning - Create Course";
include "inc/Header.php";
?>

<div class="container">
    <?php include "inc/NavBar.php"; ?>
    
    <div class="mt-5" style="max-width: 800px;">
        <!-- Course Creation Form -->
        <form id="courseForm" 
              action="Action/course-add.php"
              method="POST"
              enctype="multipart/form-data"
              class="mt-5">
            
            <?php if (isset($_GET['error'])): ?>
                <div class="alert alert-warning"><?= htmlspecialchars(Validation::clean($_GET['error'])) ?></div>
            <?php endif; ?>
            
            <?php if (isset($_GET['success'])): ?>
                <div class="alert alert-success"><?= htmlspecialchars(Validation::clean($_GET['success'])) ?></div>
            <?php endif; ?>

            <h2>Create a New Course</h2>
            <div class="mb-3">
                <label for="courseTitle" class="form-label">Course Title</label>
                <input type="text" 
                       class="form-control" 
                       id="courseTitle" 
                       name="title"
                       placeholder="Enter course title" 
                       value="<?= htmlspecialchars($title) ?>"
                       maxlength="255"
                       required />
            </div>
            
            <div class="mb-3">
                <label for="courseDescription" class="form-label">Course Description</label>
                <textarea class="form-control" 
                          id="courseDescription" 
                          name="description" 
                          rows="4" 
                          placeholder="Enter course description" 
                          maxlength="1000"
                          required><?= htmlspecialchars($description) ?></textarea>
            </div>
            
            <div class="mb-3">
                <label for="Cover" class="form-label">Cover Image</label>
                <input type="file" 
                       class="form-control" 
                       id="Cover" 
                       name="cover"
                       accept="image/*" />
            </div>

            <button type="submit" class="btn btn-primary">Create Course</button>
        </form>

        <hr class="my-5">

        <!-- Chapter Creation Form -->
        <form id="Chapter" 
              action="Action/course-chapter-add.php"
              method="POST"
              class="mt-5">
            <h2>Create a New Chapter</h2>
            
            <div class="mb-3">
                <label for="courseSelect" class="form-label">Select Course</label>
                <select class="form-select" id="courseSelect" name="course_id" required>
                    <option value="">Select a course</option>
                    <?php foreach ($courses as $course): ?>
                        <option value="<?= htmlspecialchars($course['course_id']) ?>">
                            <?= htmlspecialchars($course['title']) ?>
                        </option>
                    <?php endforeach; ?>
                </select>
            </div>
            
            <div class="mb-3">
                <label for="chapterTitle" class="form-label">Chapter Title</label>
                <input type="text" 
                       class="form-control" 
                       id="chapterTitle" 
                       name="chapter_title" 
                       placeholder="Enter chapter title"
                       maxlength="255" 
                       required>
            </div>
            
            <button type="submit" class="btn btn-primary">Create Chapter</button>
        </form>

        <hr class="my-5">

        <!-- Topic Creation Form -->
        <form id="Topic" 
              action="Action/course-topic-add.php"
              method="POST"
              class="mt-5">
            <h2>Create a New Topic</h2>
            
            <div class="mb-3">
                <label for="courseSelectTopic" class="form-label">Select Course</label>
                <select class="form-select" id="courseSelectTopic" name="course_id" required>
                    <option value="">Select a course</option>
                    <?php foreach ($courses as $course): ?>
                        <option value="<?= htmlspecialchars($course['course_id']) ?>">
                            <?= htmlspecialchars($course['title']) ?>
                        </option>
                    <?php endforeach; ?>
                </select>
            </div>
            
            <div class="mb-3">
                <label for="chapterSelect" class="form-label">Select Chapter</label>
                <select class="form-select" 
                        id="chapterSelect" 
                        name="chapter_id" 
                        required>
                    <option value="">First select a course</option>
                </select>
            </div>
            
            <div class="mb-3">
                <label for="topicTitle" class="form-label">Topic Title</label>
                <input type="text" 
                       class="form-control" 
                       id="topicTitle" 
                       name="topic_title" 
                       placeholder="Enter topic title"
                       maxlength="255" 
                       required>
            </div>
            
            <button type="submit" class="btn btn-primary">Create Topic</button>
        </form>
    </div>
</div>

<script src="../assets/js/jquery-3.5.1.min.js"></script>
<script>
$(document).ready(function() {
    $("#courseSelectTopic").change(function() {
        const courseId = $(this).val();
        const chapterSelect = $("#chapterSelect");
        
        if (!courseId) {
            chapterSelect.html('<option value="">First select a course</option>');
            return;
        }

        $.post("Action/load-chapters.php", 
            { 'course_id': courseId }, 
            function(data, status) {
                if (status === "success") {
                    if (data != 0) {
                        chapterSelect.html(data);
                    } else {
                        alert("Please create a chapter first");
                        chapterSelect.html('<option value="">No chapters available</option>');
                    }
                } else {
                    alert("Failed to load chapters. Please try again.");
                }
            }
        ).fail(function() {
            alert("Error loading chapters. Please check your connection and try again.");
        });
    });
});
</script>

<?php include "inc/Footer.php"; ?>