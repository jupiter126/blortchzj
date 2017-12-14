# blortchzj: <br />
A Stupid Password Manager (and a dumb crypted partition manager)<br />
# Credits:<br />
<br />
The name was chosen because it was unlikely.<br />
I wrote this script because on the one hand I am bad at remembering an army of strong passwords, while at the same time, I often need to connect to services from abroad.<br />
After years of being torn between the idea of storing my passwords in an unsafe place and using the same passwords at many places, I came up with this simple idea:<br />
We are bad with passwords, but good with emotions: let's apply a solid hash to an easy password, in an emotional context that is unique to each one<br />
<br />
# Usage:<br />
blortchzj will ask you for its name.<br />
The idea is that you chose a familiar name that you can associate to a phrase or set of phrases that you will remember: this will act as "seed".<br />
As the script does not save anything anywhere, you will have to remember how you initiate it to generate your passwords.<br />
<br />
# Example: <br />
<br />
$ ./blortchzj.sh <br />
oh no! my name is blortchzj, please rename me for enthropy's sake!<br />
please tell me my new name:<br />
donald<br />
Hello, my name is donald, tell me some stuff<br />
i used to like your name<br />
Anything more to tell me?<br />
not really...<br />
Anything more to tell me?<br />
<br />
I hope I know enough, now I'll give you passwords<br />
What pass would you like to know?<br />
twitter<br />
Y2RkZDE1YWFkYjcxNzg <br />
What pass would you like to know?<br />
gmail<br />
YjRlN2MxZjc3OTk1Nzc <br />
What pass would you like to know?<br />
<br />
##########

In this example, I named the app donald, then used 2 key phrases:<br />
i used to like your name<br />
not really...<br />
<br />
and pressed enter on whiteline to finish initialisation.<br />
Once completed, I then asked for twitter and gmail.<br />
<br />
Using this, it can be easy for younger and elder to use strong passwords, as you could:<br />
call it barbie and say : i like pink  - or<br />
give it your name and say : I was born on 12.12.2017<br />
<br />
NOTE:  this program is stupid: each character and space counts: change a letter to capital, add a comma or a dot and nothing is the same.<br />
NOTE2: this program is right, if password is wrong, then it is you who are wrong ;)<br />
NOTE3: for the geeks, you can easily change the hash functions called in the script for a personalised version ;p<br />



# fslartchzj is used to make an encrypted filesystem and uses blortchzj for its password.
These are usually the first things I copy on an usb stick ;p
