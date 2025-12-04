<?php
// register.php
include 'connect.php';

$username = $_POST['username'];
$password = password_hash($_POST['password'], PASSWORD_DEFAULT);
$nid = $_POST['nid'];
$dob = $_POST['dob'];
$phone = $_POST['phone'];
$email = $_POST['email'];

$image = '';
if (isset($_FILES['image'])) {
  $target_dir = "uploads/";
  if (!file_exists($target_dir)) {
    mkdir($target_dir, 0777, true);
  }
  $target_file = $target_dir . basename($_FILES["image"]["name"]);
  if (move_uploaded_file($_FILES["image"]["tmp_name"], $target_file)) {
    $image = $target_file;
  }
}

$sql = "INSERT INTO users (username, password, nid, dob, phone, email, image) VALUES ('$username', '$password', '$nid', '$dob', '$phone', '$email', '$image')";

if ($conn->query($sql) === TRUE) {
  echo json_encode(['success' => true, 'message' => 'Registration successful']);
} else {
  echo json_encode(['success' => false, 'message' => 'Error: ' . $conn->error]);
}

$conn->close();
?>