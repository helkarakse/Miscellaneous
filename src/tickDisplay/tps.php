<?php
function printTps($array) {
	foreach ($array as $key => $value) {
		$tps = round((float)$value, 2);
		print($tps . "<br />");
	}
}

function printUpdated($array) {
	foreach ($array as $key => $value) {
		print($value . "<br />");
	}
}

$dimension = isset($_GET["dim"]) ? $_GET["dim"] : "";
$date = isset($_GET["date"]) ? $_GET["date"] : false;

if ($dimension != "") {
	$filename = "tick-" . $dimension . ".txt";

	$handle = fopen($filename, "r");
	$json = fread($handle, filesize($filename));
	fclose($handle);

	$array = ($json != "") ? json_decode($json) : array();

	(count($array) > 0) ? printTps($array[0]) : print("Unknown" . "<br />");

	if ($date == true && count($array) > 0) {
		printUpdated($array[5]);
	}
} else {
	echo "Missing variable, dim (dimension).";
}
?>