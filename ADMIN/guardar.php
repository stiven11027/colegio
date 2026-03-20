<?php include("../ASSETS/conexion.php");

// Validar que los datos existan en $_POST
if (isset($_POST['tipo_documento'], $_POST['numero'], $_POST['nombre'], $_POST['email'], $_POST['password'])) {
    
    $tipo_documento = $_POST['tipo_documento'];
    $numero = $_POST['numero'];
    $nombre = $_POST['nombre'];
    $email = $_POST['email'];
    $password = md5($_POST['password']);
    
    // comprobar que el numero de documento no exista en la base de datos
    $consul_usuario = "SELECT * FROM documento WHERE num_us = '$numero'";
    $exe_colsul = mysqli_query($conexion, $consul_usuario);
    $cant_colsul = mysqli_num_rows($exe_colsul);
    if ($cant_colsul > 0) {
        echo "El número de documento ya existe en la base de datos";
    } 
    
    else {

       // insertar los datos en la base de datos
       $insert = "insert into documento
       (tip_us, num_us, nom_us, ema_us, pass_us)
       values 
        ('$tipo_documento', '$numero', '$nombre', '$email', '$password')";
       $exe_insert = mysqli_query($conexion, $insert);
       if ($exe_insert) {
           echo "Datos guardados correctamente";
       } else {
           echo "Error al guardar los datos: " . mysqli_error($conexion);
         }

    }
    
} else {
    echo "Error: Faltan datos requeridos";
}

header("Location: index.php");
?>