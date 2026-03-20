<?php 
session_start();
include '../ASSETS/conexion.php'; 

if($_SESSION['doc'] === '' || $_SESSION['doc'] === null || $_SESSION['id_rol'] != 1)
{
    $_SESSION['msg'] = "No tiene permisos. Inicie sesión como administrador";
    header('Location: ../index.php');
    die;
}

?>

<html>
    <head>
        <title>Gestión de Usuarios - Sistema Académico</title>
        <!-- PLUGINS CSS STYLE -->
        <link href="../CSS/css/sb-admin-2.css" rel="stylesheet" />
    </head>

    <main class="container-fluid p-5">
    <div class="row">
        <div class="col-md-12 col-xl-12 col-sm-12">
                <center>
                    <h1>Gestión de Usuarios</h1>
                    <p><a href="admin.php" class="btn btn-secondary btn-sm">← Volver</a></p>            
                </center>
        </div>
    </div>
    <div class="row">
        <div class="col-md-4 col-xl-4 col-sm-4">
                <br><br>
                <div class="card">
                    <div class="card-header bg-primary text-white">
                        <h5>Registrar Nuevo Usuario</h5>
                    </div>
                    <div class="card-body">
                        <form action="guardar_usuario.php" method="POST"> 
                            <div class="form-group">
                                <label>ID/Documento *</label>
                                <input type="number" class="form-control" name="id" placeholder="ID Usuario" required>
                            </div>
                            <div class="form-group">
                                <label>Nombres *</label>
                                <input type="text" name="nombres" class="form-control" placeholder="Nombres" required>
                            </div>
                            <div class="form-group">
                                <label>Apellidos *</label>
                                <input type="text" name="apellidos" class="form-control" placeholder="Apellidos" required>
                            </div>
                            <div class="form-group">
                                <label>Email</label>
                                <input type="email" name="email" class="form-control" placeholder="email@ejemplo.com">
                            </div>
                            <div class="form-group">
                                <label>Rol *</label>
                                <select class="form-control" name="id_rol" required>
                                    <option value="">-- Selecciona un rol --</option>
                                    <option value="1">Administrador</option>
                                    <option value="2">Profesor</option>
                                    <option value="3">Estudiante</option>
                                    <option value="4">Acudiente</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>Contraseña *</label>
                                <input type="password" name="pass" class="form-control" placeholder="Contraseña" required>
                            </div>
                            <div class="form-group">
                                <label>Estado</label>
                                <select class="form-control" name="estado">
                                    <option value="Activo">Activo</option>
                                    <option value="Inactivo">Inactivo</option>
                                </select>
                            </div>
                            <button type="submit" class="btn btn-primary btn-block">Registrar</button>
                        </form>
                    </div>
                </div>
                <br>
        </div>
        <div class="col-sm-8 col-md-8 col-xl-8">
        <br><br>
            <div class="card">
                <div class="card-header bg-primary text-white">
                    <h5>Lista de Usuarios</h5>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-hover table-striped">
                            <thead class="table-dark">
                                <tr>
                                    <th>ID</th>
                                    <th>Nombre Completo</th>
                                    <th>Email</th>
                                    <th>Rol</th>
                                    <th>Estado</th>
                                    <th colspan="2">Opciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php
                                //consultar los registros con rol
                                $consul_data = "SELECT * FROM usuario ORDER BY ID DESC";
                                $exe_consul = mysqli_query($conexion, $consul_data);
                                while($data_usu = mysqli_fetch_assoc($exe_consul)){
                                ?>
                                    <tr>
                                        <td><?php echo $data_usu['ID']?></td>
                                        <td><?php echo $data_usu['nombres'] . ' ' . $data_usu['apellidos']?></td>
                                        <td><?php echo $data_usu['email']?></td>
                                        <td><span class="badge bg-info"><?php echo $data_usu['nombre_rol']?></span></td>
                                        <td>
                                            <?php 
                                                if($data_usu['estado'] == 'Activo') {
                                                    echo '<span class="badge bg-success">Activo</span>';
                                                } else {
                                                    echo '<span class="badge bg-danger">Inactivo</span>';
                                                }
                                            ?>
                                        </td>                          
                                        <td><a href="actualizar_usuario.php?doc=<?= $data_usu['ID']?>" class="btn btn-warning btn-sm">Editar</a></td>
                                        <td><a href="eliminar_usuario.php?doc=<?= $data_usu['ID']?>" class="btn btn-danger btn-sm" onclick="return confirm('¿Eliminar usuario?');">Eliminar</a></td>
                                    </tr>  
                                <?php } ?>

                                    <tr>
                                        <td><?php echo $data_usu['ID']?></td>
                                        <td><?php echo $data_usu['nombres'] . ' ' . $data_usu['apellidos']?></td>
                                        <td><?php echo $data_usu['email']?></td>
                                        <td><span class="badge bg-info"><?php echo $data_usu['nombre_rol']?></span></td>
                                        <td>
                                            <?php 
                                                if($data_usu['estado'] == 'Activo') {
                                                    echo '<span class="badge bg-success">Activo</span>';
                                                } else {
                                                    echo '<span class="badge bg-danger">Inactivo</span>';
                                                }
                                            ?>
                                        </td>                          
                                        <td><a href="actualizar_usuario.php?doc=<?= $data_usu['ID']?>" class="btn btn-warning btn-sm">Editar</a></td>
                                        <td><a href="eliminar_usuario.php?doc=<?= $data_usu['ID']?>" class="btn btn-danger btn-sm" onclick="return confirm('¿Eliminar usuario?');">Eliminar</a></td>
                                    </tr>  
                                <?php  ?>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </main>

    <script src="../CSS/vendor/jquery/jquery.min.js"></script>
    <script src="../CSS/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
</html>