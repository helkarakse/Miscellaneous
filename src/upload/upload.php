<?php
	/*
	 * PHP TickProfile DataDump Handler
	 * @author Helkarakse <nimcuron@gmail.com>
	 *
	 */

	// error_reporting(E_ALL);

	$file = "tick";
	$fileExt = ".txt";
	$request = $_GET["req"];

	if ($request == "push") {
		$text = urldecode($_POST["json"]);

		$array = json_decode($text);
		$array[5]["updated"] = date("r", time());
		$text = stripslashes(json_encode($array));

		$dim = $_GET["dim"];
		$fileName = $file . "-" . $dim . $fileExt;
		$handle = fopen($fileName, "w") or die("Error: Could not open the file for writing.");
		fwrite($handle, $text);
		fclose($handle);

		echo("Updated at: " . date("r", time()));
	} else if ($request == "show") {
		$dim = $_GET["dim"];
		$fileName = $file . "-" . $dim . $fileExt;

		$handle = fopen($fileName, "r");
		$data = fread($handle, filesize($fileName));
		fclose($handle);

		if ($_GET["output"] == "json") {
			header("Content-type: application/json");
			echo($data);
		} else {
			$array = json_decode($data, true);
			echo("<p>TPS: " . round((float)$array[0]["TPS"], 2) . "</p>");
			
			$entityArray = $array[1];
			$chunkArray = $array[2];
			$typeArray = $array[3];
			$callArray = $array[4];
			
			echo("<table border='1'>");
			echo("<tr><th>%</th><th>Time/Tick</th><th>Entity</th></tr>");
			foreach ($entityArray as $key => $value) {
				echo("<tr>");
				foreach ($value as $key => $value) {
					if ($key == "Single Entity") {
						echo("<td>$value</td>");
					} else {
						echo("<td>$value</td>");
					}
				}
				echo("</tr>");
			}
			echo("</table>");
		}
	}
?>