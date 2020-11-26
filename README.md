# PWBTestGenerator
[![Build Status](https://travis-ci.com/mahugnon/PWBTestGenerator.svg?branch=master)](https://travis-ci.com/mahugnon/PWBTestGenerator) 
[![Build status](https://ci.appveyor.com/api/projects/status/rp7h5bpu5kjstbih?svg=true)](https://ci.appveyor.com/project/mahugnon/pwbtestgenerator) 
[![Build Status](https://ci.inria.fr/pharo-contribution/buildStatus/icon?job=PWBTestGenerator%2FPHARO%3D80%2CVERSION%3Dmaster)](https://ci.inria.fr/pharo-contribution/job/PWBTestGenerator/PHARO=80,VERSION=master/)
[![Build Status](https://ci.inria.fr/pharo-contribution/buildStatus/icon?job=PWBTestGenerator%2FPHARO%3D70%2CVERSION%3Dmaster)](https://ci.inria.fr/pharo-contribution/job/PWBTestGenerator/PHARO=70,VERSION=master/)
[![Coverage Status](https://coveralls.io/repos/github/mahugnon/PWBTestGenerator/badge.svg)](https://coveralls.io/github/mahugnon/PWBTestGenerator)

Load 

```Smalltalk
 Metacello new
    	githubUser: 'mahugnon' project: 'PWBTestGenerator' commitish: 'master' path: 'src';
    	baseline: 'PWBTestGenerator';
	 onConflict: [ :e | e useIncoming ];
        onUpgrade: [ :e | e useIncoming ];
        
    	load
```
