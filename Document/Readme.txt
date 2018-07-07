WebMaster : Abcd@1234+
First of all...
01.    Modify the database name in SQL file as per your connection type. NOTE : here database name id 'TICLOUDDB' (path :- Document\SQL-Migration\)
02.    Open the modified file using your db IDE/Platform and execute the whole code
03.    Open 'Connection.config' (root of WebDomain project) and modify the connection string as required.

============================================================
==========   GLOBAL CHANGES BEFORE START CODING   ==========
============================================================
The Invincible (actual application title. be careful title should not more than 14 character, otherwise design may be...)
<meta name="keywords" content="protal SEO keywords" />
<meta name="description" content="portal SEO description" />
<meta name="subject" content="portal SEO subject" />
<meta name="copyright" content="copyright company name" />
<meta name="owner" content="owner name" />
<meta name="author" content="author name" />
<meta name="designer" content="designer name" />
<meta name="url" content="http://www.portalurl.com" />
<meta name="identifier-URL" content="http://www.portalurl.com" />
<meta name="apple-mobile-web-app-title" content="portal title (for safari browser)" />
"name": "the invincible",
"version": "1.0.0",
"author": "author name",
"keywords": [ "protal SEO keywords" ]

======================================================================
==========   GLOBAL CHANGES BEFORE FINAL RELEASE(PUBLISH)   ==========
======================================================================
CODE :-
01.    Uncomment import { enableProdMode } from '@angular/core'; (main.ts)
02.    Uncomment enableProdMode(); (main.ts)
03.    Uncomment line 18 of 'root.component.ts' (ActiveFullScreen method)
04.    Uncomment whole code of 'browser.security.js' file (Scripts folder)
05.    Uncomment line 118 to 128 of 'DefaultController.cs' (Entrance action)
06.    Comment/Remove line 116, 117 of 'DefaultController.cs' (Entrance action)

GENERAL :-
01.    Clean whole solution
02.    Remove all unnessessary namespace(s) from all class
03.    Set 'Release' configuration of each project before publish
04.    Build publishing project (and check the release build in output window)
05.    Publish with existing profile named 'FolderProfile'

=====================================================================
==========   GLOBAL CHANGES AFTER FINAL RELEASE(PUBLISH)   ==========
=====================================================================
PUBLISHED OUTPUT DIRECTORY : ReleaseForProduction (solution root directory)
01.    After published 'WebDomain' application, remove 'roslyn' folder from bin directory
02.    Remove all '.pdb' & '.config' files from bin directory
03.    Remove 'bundleconfig.json.bindings' in root folder
04.    Remove 'System.Codedom' section from 'Web.config' 
05.    Change connection string as required in 'Connection.config'
06.    Change key value(s) of 'Application.config'
07.    Set 'Read/Write' permission of 'Assets' folder(including all sub folders) on IIS application directory