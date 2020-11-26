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
[![Build Status](https://travis-ci.com/mahugnon/PWBTestGenerator.svg?branch=master)](https://travis-ci.com/mahugnon/PWBTestGenerator) [![Build status](https://ci.appveyor.com/api/projects/status/rp7h5bpu5kjstbih?svg=true)](https://ci.appveyor.com/project/mahugnon/pwbtestgenerator) [![Build Status](https://ci.inria.fr/pharo-contribution/job/PWBTestGenerator/badge/icon)](https://ci.inria.fr/pharo-contribution/job/PWBTestGenerator/)
