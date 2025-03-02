<?php
session_start();
include "../../Utils/Util.php";
include "../../Utils/Validation.php";

if (isset($_SESSION['username']) && 
    isset($_SESSION['instructor_id']) && 
    isset($_POST['course_id'])) {
    
    include "../../Controller/Instructor/Course.php";
    
    $course_id = Validation::clean($_POST['course_id']);
    $chapters = getChaptersByCourseId($course_id);
    
    if ($chapters) {
        echo '<option value="">Select a chapter</option>';
        foreach ($chapters as $chapter) {
            echo '<option value="'.htmlspecialchars($chapter['chapter_id']).'">'.
                  htmlspecialchars($chapter['title']).
                 '</option>';
        }
    } else {
        echo "0";
    }
} else {
    echo "0";
}
?>