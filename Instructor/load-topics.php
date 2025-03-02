<?php
session_start();
include "../../Utils/Util.php";
include "../../Utils/Validation.php";

if (isset($_SESSION['username']) && 
    isset($_SESSION['instructor_id']) && 
    isset($_POST['chapter_id'])) {
    
    include "../../Controller/Instructor/Course.php";
    
    $chapter_id = Validation::clean($_POST['chapter_id']);
    $topics = getTopicsByChapterId($chapter_id);
    
    if ($topics) {
        echo '<option value="">Select a topic</option>';
        foreach ($topics as $topic) {
            echo '<option value="'.htmlspecialchars($topic['topic_id']).'">'.
                  htmlspecialchars($topic['title']).
                 '</option>';
        }
    } else {
        echo "0";
    }
} else {
    echo "0";
}
?>