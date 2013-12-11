<?php
	/*
	 * PHP TickProfile DataDump Handler
	 * @author Helkarakse <nimcuron@gmail.com>
	 *
	 */

	$file = "profile";
	$fileExt = ".txt";
	$request = $_GET["req"];
	
	if ($request == "push") {
		$text = urldecode(($_GET["json"]));
		$dim = $_GET["dim"];
		$fileName = $file + "-" + $dim + $fileExt;
		$handle = fopen($fileName, "w") or die("Cannot open file: " . $fileName);
		fwrite($handle, $text);
		fclose($handle);
	} else if ($request == "show") {
		$dim = $_GET["dim"];
		$fileName = $file + "-" + $dim + $fileExt;
		$handle = fopen($file, "r");
		$data = fread($handle, filesize($fileName));
		fclose($handle);
		echo($data);
	}
?>