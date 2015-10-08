<?php

// ********************************* Servicios REST ***********************************************

$arr = split("/", $_SERVER['REQUEST_URI']);

$firstComponentURI = substr($arr[1],0,4);

if($firstComponentURI == "rest"){

	if($_SERVER['REQUEST_METHOD'] == 'POST'){
			$obj = json_decode(file_get_contents("php://input"));
			$sql = "insert into tasks (id, task, description) values (".$obj->id.",'".$obj->task."','".$obj->description."')";
			ejecutar_sql($sql);
	}

	if($_SERVER['REQUEST_METHOD'] == 'DELETE'){
		ejecutar_sql("delete from tasks where id=".$_GET[id]);
	}

	if($_SERVER['REQUEST_METHOD'] == 'PUT'){
		$obj = json_decode(file_get_contents("php://input"));
		$sql = "update tasks set task='".$obj->task."', description='".$obj->description."' where id=".$obj->id;
		ejecutar_sql($sql);
	}
	
	exit();	
}
// ********************************* FIN Servicios REST ***********************************************

echo "<head><meta charset='UTF-8'></head>";

echo "<h1>Tasks</h1><hr>";
$sql = "select * from tasks"; 
$res = ejecutar_sql($sql );

while($reg=mysql_fetch_array($res))
{
	echo "Task: <b>" . $reg['task'] . "</b> Description: <b>".$reg['description']."</b><br>";
}

function ejecutar_sql($sql)
{
	syslog(LOG_INFO, "ejecutar_sql > ".$sql);
	//echo $sql;
	//$con = mysql_connect(':/cloudsql/ceperalta-fast-tabla:db','root','');
	$con = mysql_connect('localhost:3307','root','contra');
	mysql_select_db('fasttabla');
	$res = mysql_query($sql,$con);
	mysql_close($con);
	
	return $res;
}


/*
//jdbc:google:mysql://vaadincep2:db/telefonos
	final public static String strURLConDBGoogleCloudSQL = "jdbc:google:mysql://scptest-645:db/scp";
	final public static String strClaveBDGoogleCloudSQL = "";


En Navicat: :/cloudsql/ceperalta-fast-tabla:db


*/

?>

