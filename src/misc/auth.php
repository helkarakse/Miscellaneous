<?php
	/*
	 * PHP OTEGlasses Authentication Handler
	 * @author Helkarakse <nimcuron@gmail.com>
	 *
	 */

	// error_reporting(E_ALL);
	
	$username = $_GET["name"];
	$array = array();
	
	if ($username == "helkarakse") {
		echo(md5("1"));
	}
?>