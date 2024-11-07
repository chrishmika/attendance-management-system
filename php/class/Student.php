<?php
class Student
{
    private $course = 'uoj_course';
    private $class = 'uoj_class';
    private $std = 'uoj_student';
    private $conn;
    private $stdId;

    public function __construct($database)
    {
        $this->conn = $database;
    }

    public function getClassByStudent($stdId, $startDate = "", $endDate = "") {
        $query = "SELECT {$this->class}.*, {$this->course}.course_code, {$this->course}.course_name  
                  FROM {$this->class}
                  INNER JOIN {$this->course} ON {$this->course}.course_id = {$this->class}.course_id
                  INNER JOIN uoj_student_class ON uoj_student_class.class_id = {$this->class}.class_id
                  WHERE uoj_student_class.std_id = ?";
    
        if ($startDate != "") {
            $query .= " AND {$this->class}.class_date BETWEEN ? AND ?";
        }
    
        $stmt = $this->conn->prepare($query);
        if ($startDate != "") {
            $stmt->bind_param('iss', $stdId, $startDate, $endDate);
        } else {
            $stmt->bind_param('i', $stdId);
        }
    
        return $stmt->execute() ? $stmt->get_result() : false;
    }    
}
?>