<?php
	/*
	 * PHP OTEGlasses Config Backup Handler
	 * @author Helkarakse <nimcuron@gmail.com>
	 *
	 */

	// error_reporting(E_ALL);

	$username = $_GET["name"];
	$dimension = $_GET["dim"];
	
	$text = urldecode($_POST["config"]);
	
	$array = json_decode($text);
	$array[]["create_date"] = date("r", time());
	$text = stripslashes(json_encode($array));

	$filename = "./backup/" . $dim . "-" . $username . ".txt";
	
	$handle = fopen($filename, "w") or die("Error: Could not open the file for writing.");
	fwrite($handle, $text);
	fclose($handle);

	echo("Configuration backup successful: " . date("r", time()));
?>