<?php
                    $username = $_SESSION['user_info']['username'];
                    $conn = mysqli_connect('localhost', 'root', '', 'olcs');
                    $query = "SELECT referenced_id FROM users WHERE username = '$username'";
                    $result = mysqli_query($conn, $query);
                    $row = mysqli_fetch_assoc($result);
                    $referenced_id = $row['referenced_id'];
                    $query = "SELECT first_name, last_name FROM clients WHERE client_id = '$referenced_id'";
                    $result = mysqli_query($conn, $query);
                    $row = mysqli_fetch_assoc($result);
                    $firstname = $row['first_name'];
                    $lastname = $row['last_name'];
                    echo $firstname . " " . $lastname;
                    ?>