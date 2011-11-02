README:

!!!!!!!Please use vcl to run the application.!!!!!!

This project can finish the job of 1. import user 2. import topic 3.import aasignment Teams 4.import assignment participants 5.import course team 6.import course participant. 

Follow steps below to do the test:
1. Run the project. Then there is a page for you to login in.
2. Use Username: admin Password: password to login in as system admin.

Common things about tests:
How to create .csv file?
1. Open excel
2. Input the sequence you specify, input each parameter in each grid. For example, username1,fullname1,username1@ncsu.edu,pw1234
3. Click SAVE AS and choose 'the other format'.
4. Choose *.csv and click 'OK'.
Note: In *.csv file, the default delimiter is comma. So if you want to choose another delimiter such as space and tab, you need to create the csv file using notepad. And make sure if  one column is missed, you need to type two delimiter together to indicate the missing column. For example, username1,,username1@ncsu.edu,pw1234

For example, to test 'import users' :
1. Click the menu: Manage…. Scroll down the page and click the link: import users
There you may see four drop down boxes, you may select the sequence of imported files: **.csv
Now create a file as told above and make sure the delimiter you specify on the page is identical to the one created in *.csv. And if the sequence you selected is FULLNAME USERNAME E-MAIL PASSWORD. Here is an example of the content in .csv file: fullname1,username1,username1@ncsu.edu,pw1234 . Then select this file and import it. After importing it,  you may see the default order of USERNAME FULLNAME E-MAIL PASSWORD.

On top of that, to test 'import topic'
1. Run the application and type the hyperlink: localhost:3000/sign_up_sheet/add_signup_topics/147.
2. Click the link 'import topics'. 
There you may see four drop down box, you may select the sequence of imported files: **.csv
Now create a file as told above and make sure the delimiter you specify on the page is identical to the one created in *.csv. And the sequence you select is NAME IDENTIFIER MAXCHOOSERS TOPICCATEGORY. Here is an example of the content in .csv file: name1, Identifier1, 4, life . Then select this file and import it. After import it,  you may see the default order of IDENTIFIER NAME MAXCHOOSERS TOPICCATEGORY.

Other tests are similar as above, you may test them as you like. 

Possible situations for importing users:

1. Sheet is qualified as what required in the system:
eg: username1,fullname1,username1@ncsu.edu,pw1234
    username2,fullname2,username2@ncsu.edu,pw1234
    username3,fullname3,username3@ncsu.edu,pw1234
    username4,fullname4,username4@ncsu.edu,pw1234

result: You can import the .csv file successfully!

2. The order of column in the Sheet is not the same as required in the system:
eg: fullname1,username1,username1@ncsu.edu,pw1234
    fullname2,username2,username2@ncsu.edu,pw1234
    fullname3,username3,username3@ncsu.edu,pw1234
    fullname4,username4,username4@ncsu.edu,pw1234

In this case, you should the click the drop-down boxes in the system as :Fullname, username,email, password before import the file.

result: You can import the .csv file successfully!

3. If in some rows there are some blank columns:
eg: username1,,username1@ncsu.edu,pw1234
    username2,fullname2,username2@ncsu.edu,pw1234
    username3,fullname3,,pw1234
    username4,fullname4,username4@ncsu.edu,pw1234

result: The system will give the warning as: line 1: "full name" is missing. line3: "email address" is missing.

4. If in some rows there are some addition columns:
eg: username1,fullname1,username1@ncsu.edu,pw1234,add
    username2,fullname2,username2@ncsu.edu,pw1234
    username3,fullname3,username3@ncsu.edu,pw1234,add,add
    username4,fullname4,username4@ncsu.edu,pw1234

result: The system will give the warning as line 1: extra items exist, line 3: extra items exist.

And they may be another situations for importing file. You can test yourself and see what will happen.


 