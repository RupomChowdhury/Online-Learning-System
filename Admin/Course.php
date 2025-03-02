<?php 
session_start();
include "../Utils/Util.php";
include "../Utils/Validation.php";

// Check user authentication
if (!isset($_SESSION['username']) || !isset($_SESSION['admin_id'])) {
    Util::redirect("../login.php", "error", "Please login first");
    exit();
}

// Initialize variables
$title = "VuLearning";
$chapter_title = '';
$topic_title = '';
$num_topic = 0;

// Check if course_id is set
if (!isset($_GET['course_id'])) {
    Util::redirect("courses.php", "error", "Invalid course ID");
    exit();
}

// Include course controller
include "../Controller/Admin/Course.php";

// Clean and validate inputs
$_id = Validation::clean($_GET['course_id']);
$_chapter_id = isset($_GET['chapter']) ? Validation::clean($_GET['chapter']) : 1;
$_topic_id = isset($_GET['topic']) ? Validation::clean($_GET['topic']) : 1;

// Check page exercises
$page_exes = pageExes($_id, $_chapter_id);
if ($page_exes == 0) {
    Util::redirect("../404.php", "error", "404");
    exit();
}

// Get course data
$course = getById($_id, $_chapter_id, $_topic_id);
if (!$course || empty($course['course']['course_id'])) {
    Util::redirect("courses.php", "error", "Invalid course id");
    exit();
}

// Set page title
$title = "VuLearning - " . htmlspecialchars($course['course']["title"]);

// Include header
include "inc/Header.php";
?>

<div class="container">
    <!-- NavBar & Profile-->
    <?php include "inc/NavBar.php"; ?>
    
    <div class="side-by-side mt-5">
        <!-- Left Sidebar -->
        <div class="l-side shadow p-3">
            <ul class="list-group">
                <?php 
                if (!empty($course['chapters']) && is_array($course['chapters'])) {
                    foreach ($course['chapters'] as $chapter) { 
                ?>
                    <li class="list-group-item">
                        <a href="#" class="btn badge-primary">
                            <?= htmlspecialchars($chapter['title']) ?>
                        </a>
                        <ul>
                            <?php 
                            if (!empty($course['topics']) && is_array($course['topics'])) {
                                foreach ($course['topics'] as $topic) {
                                    // Skip if topic doesn't belong to current chapter
                                    if ($chapter['chapter_id'] != $topic['chapter_id']) continue;

                                    // Set chapter and topic titles if current
                                    if ($chapter['chapter_id'] == $_chapter_id && 
                                        $topic['topic_id'] == $_topic_id) {
                                        $num_topic++;
                                        $chapter_title = $chapter['title'];
                                        $topic_title = $topic['title'];
                                    }
                            ?>
                                <li>
                                    <a href="Course.php?course_id=<?= htmlspecialchars($_id) ?>&chapter=<?= htmlspecialchars($chapter['chapter_id']) ?>&topic=<?= htmlspecialchars($topic['topic_id']) ?>" 
                                       class="btn badge-primary">
                                        <?= htmlspecialchars($topic["title"]) ?>
                                    </a>
                                </li>
                            <?php 
                                }
                            } 
                            ?>
                        </ul>
                    </li>
                <?php 
                    }
                } 
                ?>
            </ul>
        </div>

        <!-- Right Content Area -->
        <div class="r-side p-5 shadow">
            <h5><?= htmlspecialchars($course['course']["title"]) ?></h5>
            <h6><?= htmlspecialchars($chapter_title) ?> - <?= htmlspecialchars($topic_title) ?></h6>
            <hr>
            <div>
                <?php 
                if (!empty($course['content']["data"])) {
                    // Note: If content data contains HTML that should be rendered,
                    // make sure it's from a trusted source or sanitize it appropriately
                    echo $course['content']["data"]; 
                } 
                ?>
            </div>
        </div>
    </div>
</div>

<!-- Footer -->
<?php include "inc/Footer.php"; ?>