<?php
function printTps($array) {
	foreach ($array as $key => $value) {
		$tps = round((float)$value, 2);
		print($tps);
	}
}

$dimension = $_GET["dim"];
$filename = "tick-" . $dimension . ".txt";

$handle = fopen($filename, "r");
$json = fread($handle, filesize($filename));
fclose($handle);

$array = ($json != "") ? json_decode($json) : array();

var_dump($array);

(count($array) > 0) ? printTps($array[0]) : print("Unknown");
?>