<?php

if($_POST['formSubmit'] == "Complete")
{
	$varName = $_POST['formName'];
	$varQ1 = $_POST['formQ1'];
	$varQ2 = $_POST['formQ2'];
	$varQ3 = $_POST['formQ3'];
	$varQ4 = $_POST['formQ4'];
	$varQ5 = $_POST['formQ5'];
	$contents="\n\n\nJulia6\n\nContacts: $varName\nQ1: $varQ1\nQ2: $varQ2\nQ3: $varQ3\nQ4: $varQ4\nQ5: $varQ5";

	$myFile = "submissions.txt";
	if (!file_exists($myFile)) {
	  print 'File not found';
	}
	$fh = fopen($myFile, 'a') or die("can't open file");
	fwrite($fh, $contents);
	fclose($fh);
	header("Location: completed.html");
	exit;
}
?>
<!DOCTYPE HTML>
<html>
<head>
	<title>GWAM</title>
	<link rel="stylesheet" type="text/css" href="../style.css">
</head>

<body>
	<h1>Julia</h1>
	<p>These questions can be answered by reading the Julia-manual:  <a href="http://docs.julialang.org/en/release-0.2/manual/">http://docs.julialang.org/en/release-0.2/manual/</a></p>

	<form action="julia6.php" method="post">
		<p>
			Your contact details:<br>
			<input type="text" name="formName" maxlength="500" value="<?=$varName;?>" />
		</p>
		<p>
What is multiple dispatch?
<br>
			<input type="text" name="formQ1" maxlength="900" value="<?=$varQ1;?>" />
		</p>	
		<p>
How is code from a file (a script) run?
<br>
			<input type="text" name="formQ2" maxlength="900" value="<?=$varQ2;?>" />
		</p>
		<p>
How are names of variables restricted?
			<br>
			<input type="text" name="formQ3" maxlength="900" value="<?=$varQ3;?>" />
		</p>
		<p>
What is overflow?
			<br>
			<input type="text" name="formQ4" maxlength="900" value="<?=$varQ4;?>" />
		</p>
		<p>
What is the difference between "a=1" and "a==1"?
			<br>
			<input type="text" name="formQ5" maxlength="900" value="<?=$varQ5;?>" />
		</p>
				
		<input type="submit" name="formSubmit" value="Complete" />
	</form>
	<p>Murakoze cyane!<br>
	&lt;3</p>
</body>
</html>
