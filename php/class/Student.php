<?php
class Student
{

    private $std = 'uoj_student';
    private $conn;

    private $stdId;

    public function __construct($database)
    {
        $this->conn = $database;
    }

    public function getClassByStudent($stdId, $startDate = "", $endDate = "")
    {
        // Construct the SQL query to select classes for a specific student
        $query = "SELECT {$this->class}.*, {$this->course}.course_code, {$this->course}.course_name  
              FROM {$this->class}
              INNER JOIN {$this->course} ON {$this->course}.course_id = {$this->class}.course_id
              INNER JOIN uoj_student_class ON uoj_student_class.class_id = {$this->class}.class_id
              WHERE student_class.std_id = ?";

        // Add date range filter if startDate and endDate are provided
        if ($startDate != "") {
            $query .= " AND {$this->class}.class_date BETWEEN ? AND ?";
        }

        // Prepare and bind parameters for the SQL statement
        $stmt = $this->conn->prepare($query);
        if ($startDate != "") {
            $stmt->bind_param('iss', $stdId, $startDate, $endDate);
        } else {
            $stmt->bind_param('i', $stdId);
        }

        // Execute the query and return the results
        if ($stmt->execute()) {
            return $stmt->get_result();
        } else {
            return false;
        }
    }


}
?>