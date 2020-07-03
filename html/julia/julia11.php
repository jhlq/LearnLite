<?php

if($_POST['formSubmit'] == "Complete")
{
$varName = $_POST['formName'];
$varQ1 = $_POST['formQ1'];
$varQ2 = $_POST['formQ2'];
$varQ3 = $_POST['formQ3'];
$varQ4 = $_POST['formQ4'];
$varQ5 = $_POST['formQ5'];

$contents="\n\n\nJulia11\n\nContacts: $varName\nQ1: $varQ1\nQ2: $varQ2\nQ3: $varQ3\nQ4: $varQ4\nQ5: $varQ5\n";

$subFile = "submissions.txt";
if (!file_exists($subFile)) {
  print 'File not found';
}
$fh = fopen($subFile, 'a') or die("can't open file");
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
<p>These questions can be answered by reading this page:  <a href="http://julia.readthedocs.org/en/latest/stdlib/base/">http://julia.readthedocs.org/en/latest/stdlib/base/</a></p>

<form action="julia11.php" method="post">
<p>
Your contact details:<br>
<input type="text" name="formName" maxlength="500" value="<?=$varName;?>" />
</p>
<p>
What is the difference between <b>isequal(x,y)</b> and <b>x==y</b>?
<br>
<input type="text" name="formQ1" maxlength="900" value="<?=$varQ1;?>" />
</p>	
<p>
Describe the evaluation of this expression:
(NaN===NaN)==(NaN==NaN)
<br>
<input type="text" name="formQ2" maxlength="900" value="<?=$varQ2;?>" />
</p>	
<p>
Describe the difference between <b>copy(a)</b> and <b>deepcopy(a)</b>
<br>
<input type="text" name="formQ3" maxlength="900" value="<?=$varQ3;?>" />
</p>	
<p>
What is the result of <b>convert(Integer,1.2)</b>?
<br>
<input type="text" name="formQ4" maxlength="900" value="<?=$varQ4;?>" />
</p>	
<p>
Describe the functionality of <b>|&gt;</b>
<br>
<input type="text" name="formQ5" maxlength="900" value="<?=$varQ5;?>" />
</p>	
<input type="submit" name="formSubmit" value="Complete" />
</form>
<p>Murakoze cyane!<br>
&lt;3</p>
</body>
</html>
