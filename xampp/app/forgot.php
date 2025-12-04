<?php
// forgot.php
include 'connect.php';

$nid = $_POST['nid'];
$new_password = password_hash($_POST['new_password'], PASSWORD_DEFAULT);

$sql = "UPDATE users SET password = '$new_password' WHERE nid = '$nid'";

if ($conn->query($sql) === TRUE && $conn->affected_rows > 0) {
  echo json_encode(['success' => true, 'message' => 'Password reset successful']);
} else {
  echo json_encode(['success' => false, 'message' => 'Invalid NID']);
}

$conn->close();
?>