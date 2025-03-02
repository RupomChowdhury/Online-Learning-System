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
$courses = getCoursesByInstructorId($instructor_id);

if (!$courses) {
    $courses = [];
}

// Get form values if they exist
$title = isset($_GET["title"]) ? Validation::clean($_GET["title"]) : "";
$description = isset($_GET["description"]) ? Validation::clean($_GET["description"]) : "";

# Header
$page_title = "VuLearning - Create Course";
include "inc/Header.php";
?>

<div class="container">
    <?php include "inc/NavBar.php"; ?>
    
    <div class="container mt-5">
        <form action="Action/create-content.php" 
              method="POST"
              class="border p-5 rounded shadow-sm">
            
            <?php if (isset($_GET['error'])): ?>
                <div class="alert alert-warning"><?= htmlspecialchars(Validation::clean($_GET['error'])) ?></div>
            <?php endif; ?>
            
            <?php if (isset($_GET['success'])): ?>
                <div class="alert alert-success"><?= htmlspecialchars(Validation::clean($_GET['success'])) ?></div>
            <?php endif; ?>

            <h4 class="mb-4">Create / Edit Course Content</h4>
            
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
                    <option value="">Select a chapter</option>
                </select>
            </div>
            
            <div class="mb-3">
                <label for="topicSelect" class="form-label">Select Topic</label>
                <select class="form-select" 
                        id="topicSelect" 
                        name="topic_id" 
                        required>
                    <option value="">Select a topic</option>
                </select>
            </div>
            
            <button type="submit" 
                    class="btn btn-warning" 
                    id="submitBtn">
                Load Content
            </button>
        </form>
    </div>
</div>

<script src="../assets/js/jquery-3.5.1.min.js"></script>
<script>
$(document).ready(function() {
    const chapterSelect = $("#chapterSelect");
    const topicSelect = $("#topicSelect");
    const submitBtn = $("#submitBtn");
    
    // Initial load
    updateTopicSelect();
    updateChapterSelect();

    function updateChapterSelect() {
        const courseId = $("#courseSelectTopic").val();
        if (!courseId) {
            chapterSelect.html('<option value="">Select a chapter</option>');
            return;
        }
    }

    function updateTopicSelect() {
        const chapterId = $("#chapterSelect").val();
        if (!chapterId) {
            topicSelect.html('<option value="">Select a topic</option>');
            return;
        }
    }

    $("#courseSelectTopic").change(function() {
        const courseId = $(this).val();
        
        // Reset dependent selects
        topicSelect.html('<option value="">Select a topic</option>');
        
        if (!courseId) {
            chapterSelect.html('<option value="">Select a chapter</option>');
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
                }
            }
        ).fail(function() {
            alert("Error loading chapters. Please try again.");
        });
    });

    chapterSelect.change(function() {
        const chapterId = $(this).val();
        
        if (!chapterId) {
            topicSelect.html('<option value="">Select a topic</option>');
            return;
        }

        $.post("Action/load-topics.php", 
            { 'chapter_id': chapterId }, 
            function(data, status) {
                if (status === "success") {
                    if (data != 0) {
                        topicSelect.html(data);
                    } else {
                        alert("Please create a topic first");
                        topicSelect.html('<option value="">No topics available</option>');
                    }
                }
            }
        ).fail(function() {
            alert("Error loading topics. Please try again.");
        });
    });
});
</script>

<?php include "inc/Footer.php"; ?>