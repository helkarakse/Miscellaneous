<?php
/*
 * PHP TickProfile DataDump Handler
 * @author Helkarakse <nimcuron@gmail.com>
 *
 */

// error_reporting(E_ALL);
header("Content-type: application/json");

$file = "tick";
$fileExt = ".txt";
$request = $_GET["req"];

if ($request == "push")
{
	$text = urldecode(($_POST["json"]));
	
	$array = json_decode($text);
	$array["last_update"] = date("r", time());
	$text = json_encode($array);
	
	$dim = $_GET["dim"];
	$fileName = $file . "-" . $dim . $fileExt;
	$handle = fopen($fileName, "w") or die("Cannot open file: " . $fileName);
	fwrite($handle, $text);
	fclose($handle);
}
else if ($request == "show")
{
	$dim = $_GET["dim"];
	$fileName = $file . "-" . $dim . $fileExt;
	
	$handle = fopen($fileName, "r");
	$data = fread($handle, filesize($fileName));
	fclose($handle);
	
	if ($_GET["output"] == "json")
	{
		print_r($data);
	}
	else
	{
		echo ($data);
	}
}
?>