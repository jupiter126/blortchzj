#blortchzj: 
A Stupid Password Manager

The name was chosen because it was unlikely.
I wrote this script because on the one hand I am bad at remembering an army of strong passwords, while at the same time, I often need to connect to services from abroad.
After years of being torn between the idea of storing my passwords in an unsafe place and using the same passwords at many places, I came up with this simple idea:
We are bad with passwords, but good with emotions: let's apply a solid hash to an easy password, in an emotional context that is unique to each one

Usage:
blortchzj will ask you for its name.
The idea is that you chose a familiar name that you can associate to a phrase or set of phrases that you will remember: this will act as "seed".
As the script does not save anything anywhere, you will have to remember how you initiate it to generate your passwords.

Example: 

$ ./blortchzj.sh 
oh no! my name is blortchzj, please rename me for enthropy's sake!
please tell me my new name:
donald
Hello, my name is donald, tell me some stuff
i used to like your name
Anything more to tell me?
not really...
Anything more to tell me?

I hope I know enough, now I'll give you passwords
What pass would you like to know?
twitter
Y2RkZDE1YWFkYjcxNzg 
What pass would you like to know?
gmail
YjRlN2MxZjc3OTk1Nzc 
What pass would you like to know?

##########

In this example, I named the app donald, then used 2 key phrases:
i used to like your name
not really...


and pressed enter on whiteline to finish initialisation.
Once completed, I then asked for twitter and gmail.


Using this, it can be easy for younger and elder to use strong passwords, as you could:
call it barbie and say : i like pink  - or
give it your name and say : I was born on 12.12.2017


NOTE:  this program is stupid: each character and space counts: change a letter to capital, add a comma or a dot and nothing is the same.
NOTE2: this program is right, if password is wrong, then it is you who are wrong ;)
NOTE3: for the geeks, you can easily change the hash functions called in the script for a personalised version ;p
