<?php
	/*
	 * PHP TickProfile DataDump Handler
	 * @author Helkarakse <nimcuron@gmail.com>
	 *
	 */

	$file = "profile.txt";
	$request = $_GET["req"];
	
	if ($request == "push") {
		$text = urldecode(($_POST["json"]));
		$handle = fopen($file, "w") or die("Cannot open file: " . $file);
		fwrite($handle, $text);
		fclose($handle);
	} else if ($request == "show") {
		$handle = fopen($file, "r");
		$data = fread($handle, filesize($file));
		fclose($handle);
		echo($data);
	}
?>