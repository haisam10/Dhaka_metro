<?php
// get_username.php
include 'connect.php';

$nid = $_POST['nid'];

$sql = "SELECT username FROM users WHERE nid = '$nid'";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
  $row = $result->fetch_assoc();
  echo json_encode(['success' => true, 'username' => $row['username']]);
} else {
  echo json_encode(['success' => false, 'message' => 'Invalid NID']);
}

$conn->close();
?>