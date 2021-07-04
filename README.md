# PWBTestGenerator
[![Build status](https://ci.appveyor.com/api/projects/status/rp7h5bpu5kjstbih?svg=true)](https://ci.appveyor.com/project/mahugnon/pwbtestgenerator) 
[![Build Status](https://ci.inria.fr/pharo-contribution/job/PWBTestGenerator/badge/icon)](https://ci.inria.fr/pharo-contribution/job/PWBTestGenerator/)
![Github Actions build](https://github.com/mahugnon/PWBTestGenerator/workflows/Github%20Actions%20build/badge.svg)
[![Coverage Status](https://coveralls.io/repos/github/mahugnon/PWBTestGenerator/badge.svg?branch=main)](https://coveralls.io/github/mahugnon/PWBTestGenerator?branch=main)


Load 

```Smalltalk
 Metacello new
    	githubUser: 'mahugnon' project: 'PWBTestGenerator' commitish: 'main' path: 'src';
    	baseline: 'PWBTestGenerator';
	 onConflict: [ :e | e useIncoming ];
        onUpgrade: [ :e | e useIncoming ];
        
    	load
```
