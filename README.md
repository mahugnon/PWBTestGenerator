# PWBTestGenerator

Load 

```Smalltalk
 Metacello new
    	githubUser: 'mahugnon' project: 'PWBTestGenerator' commitish: 'master' path: 'src';
    	baseline: 'PWBTestGenerator';
	 onConflict: [ :e | e useIncoming ];
        onUpgrade: [ :e | e useIncoming ];
        
    	load
```
[![Build Status](https://travis-ci.com/mahugnon/PWBTestGenerator.svg?branch=master)](https://travis-ci.com/mahugnon/PWBTestGenerator)
