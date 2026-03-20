<?php 
include 'head_admin.php';
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Panel Administrador - Sistema Académico</title>
    <link href="../CSS/css/sb-admin-2.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .dashboard-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 30px 0;
            margin-bottom: 30px;
        }
        .dashboard-header h1 {
            margin: 0;
            font-size: 2.5rem;
            font-weight: bold;
        }
        .dashboard-header p {
            margin: 10px 0 0 0;
            font-size: 1.1rem;
        }
        .stat-card {
            border-left: 4px solid #667eea;
            padding: 20px;
            border-radius: 5px;
            background: white;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }
        .stat-card h3 {
            margin: 0 0 10px 0;
            color: #667eea;
            font-size: 0.9rem;
            text-transform: uppercase;
            font-weight: bold;
        }
        .stat-card .number {
            font-size: 2rem;
            font-weight: bold;
            color: #333;
        }
        .menu-card {
            display: block;
            padding: 20px;
            border-radius: 5px;
            background: white;
            text-decoration: none;
            color: #333;
            border-left: 4px solid #667eea;
            transition: all 0.3s;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            margin-bottom: 15px;
        }
        .menu-card:hover {
            text-decoration: none;
            color: #667eea;
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
            transform: translateY(-2px);
        }
        .menu-card i {
            font-size: 1.5rem;
            margin-right: 15px;
            color: #667eea;
        }
        .menu-card h4 {
            margin: 0;
            font-size: 1.1rem;
            font-weight: bold;
        }
        .menu-card p {
            margin: 5px 0 0 0;
            font-size: 0.9rem;
            color: #666;
        }
        .logout-btn {
            position: absolute;
            top: 20px;
            right: 20px;
        }
    </style>
</head>
<body>
    <div class="dashboard-header">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h1>Dashboard</h1>
                    <p>Bienvenido <?= htmlspecialchars($data_usu['nombres']) ?></p>
                </div>
                <div class="col-md-4 text-end">
                    <a href="admin.php" class="btn btn-light btn-sm me-2">
                        <i class="fas fa-home"></i> Inicio
                    </a>
                    <a href="../index.php?logout=1" class="btn btn-outline-light btn-sm">
                        <i class="fas fa-sign-out-alt"></i> Salir
                    </a>
                </div>
            </div>
        </div>
    </div>

    <div class="container">
        <!-- Estadísticas -->
        <div class="row mb-4">
            <div class="col-md-3">
                <div class="stat-card">
                    <h3>Total de Usuarios</h3>
                    <div class="number">
                        <?php
                        $q_usuarios = "SELECT COUNT(*) as total FROM usuario";
                        $r_usuarios = mysqli_query($conexion, $q_usuarios);
                        $d_usuarios = mysqli_fetch_assoc($r_usuarios);
                        echo $d_usuarios['total'];
                        ?>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stat-card">
                    <h3>Estudiantes</h3>
                    <div class="number">
                        <?php
                        $q_est = "SELECT COUNT(*) as total FROM usuario WHERE id_rol = 3";
                        $r_est = mysqli_query($conexion, $q_est);
                        $d_est = mysqli_fetch_assoc($r_est);
                        echo $d_est['total'];
                        ?>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stat-card">
                    <h3>Profesores</h3>
                    <div class="number">
                        <?php
                        $q_prof = "SELECT COUNT(*) as total FROM usuario WHERE id_rol = 2";
                        $r_prof = mysqli_query($conexion, $q_prof);
                        $d_prof = mysqli_fetch_assoc($r_prof);
                        echo $d_prof['total'];
                        ?>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stat-card">
                    <h3>Cursos</h3>
                    <div class="number">
                        <?php
                        $q_cur = "SELECT COUNT(*) as total FROM curso";
                        $r_cur = mysqli_query($conexion, $q_cur);
                        $d_cur = mysqli_fetch_assoc($r_cur);
                        echo $d_cur['total'];
                        ?>
                    </div>
                </div>
            </div>
        </div>

        <!-- Menú de opciones -->
        <div class="row">
            <div class="col-md-12">
                <h3 class="mb-4">Opciones del Sistema</h3>
            </div>
        </div>

        <div class="row">
            <div class="col-md-4">
                <a href="usuarios.php" class="menu-card">
                    <i class="fas fa-users"></i>
                    <div>
                        <h4>Gestión de Usuarios</h4>
                        <p>Crear, editar y eliminar usuarios del sistema</p>
                    </div>
                </a>
            </div>
            <div class="col-md-4">
                <a href="../DOCENTES/docente.php" class="menu-card">
                    <i class="fas fa-chalkboard-user"></i>
                    <div>
                        <h4>Gestión de Docentes</h4>
                        <p>Administrar profesores y asignaciones</p>
                    </div>
                </a>
            </div>
            <div class="col-md-4">
                <a href="../ESTUDIANTES/estudiante.php" class="menu-card">
                    <i class="fas fa-graduation-cap"></i>
                    <div>
                        <h4>Gestión de Estudiantes</h4>
                        <p>Administrar estudiantes y progreso académico</p>
                    </div>
                </a>
            </div>
        </div>

        <div class="row mt-3">
            <div class="col-md-4">
                <a href="#" class="menu-card">
                    <i class="fas fa-book"></i>
                    <div>
                        <h4>Gestión de Calificaciones</h4>
                        <p>Registrar y consultar calificaciones</p>
                    </div>
                </a>
            </div>
            <div class="col-md-4">
                <a href="#" class="menu-card">
                    <i class="fas fa-calendar-check"></i>
                    <div>
                        <h4>Asistencia</h4>
                        <p>Registrar asistencia de estudiantes</p>
                    </div>
                </a>
            </div>
            <div class="col-md-4">
                <a href="#" class="menu-card">
                    <i class="fas fa-clock"></i>
                    <div>
                        <h4>Horarios</h4>
                        <p>Gestionar horarios de clases</p>
                    </div>
                </a>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>