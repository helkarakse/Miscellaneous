<?php
function printTps($array) {
	foreach ($array as $key => $value) {
		$tps = round((float)$value, 2);
		print($tps);
	}
}

$dimension = $_GET["dim"];

if ($dimension == 1) {
	$json = file_get_contents("http://otegamers.com/custom/helkarakse/upload.php?req=show&dim=1");
} elseif ($dimension == 2) {
	$json = file_get_contents("http://otegamers.com/custom/helkarakse/upload.php?req=show&dim=2");
}

$array = ($json != "") ? json_decode($json) : array();

(count($array) > 0) ? printTps($array[0]) : print("Unknown");
?>