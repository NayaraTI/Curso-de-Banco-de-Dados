<?php
$nome = $_POST['NomeCliente'];
$sobrenome = $_POST['SobrenomeCliente'];
$sexo = $_POST['Sexo'];
$strcon = mysqli_connect('localhost','joao','@joao123','app') or die('Erro ao conectar ao banco de dados');
$sql = "INSERT INTO cadastro VALUES ";
$sql .= "('$nome', '$sobrenome', '$sexo')"; 
mysqli_query($strcon,$sql) or die("Erro ao tentar cadastrar registro");
mysqli_close($strcon);
echo "Cliente cadastrado com sucesso!";
echo "<a href='formulario.html'>Clique aqui para realizar um novo cadastro</a><br>";
echo "<a href='consulta.php'>Clique aqui para realizar uma consulta</a><br>";
?>