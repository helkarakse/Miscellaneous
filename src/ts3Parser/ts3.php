<?php
error_reporting(E_ALL);
header('Content-type: application/json');
require_once ("libts3/TeamSpeak3.php");

// Variables
$ip = "ts3.otegamers.com";
$port = 10011;

$server = TeamSpeak3::factory("serverquery://" . $ip . ":" . $port . "/");
$clientList = $server -> clientList();
foreach ($clientList as $ts3_Client) {
	echo $ts3_Client . " is using " . $ts3_Client["client_platform"] . "<br />\n";
}
?>