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
