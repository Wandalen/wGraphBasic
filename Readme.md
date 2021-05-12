
# module::GraphBasic [![status](https://github.com/Wandalen/wgraphbasic/actions/workflows/StandardPublish.yml/badge.svg)](https://github.com/Wandalen/wgraphbasic/actions/workflows/StandardPublish.yml) [![stable](https://img.shields.io/badge/stability-stable-brightgreen.svg)](https://github.com/emersion/stability-badges#stable)

Collection of abstract data structures and algorithms to process graphs. The module does not bound to any specific format of a graph, so providing adapters toy may use it with anyone. It implements depth-first search, breadth-first search, extracting strongly connected components, topological sort, shortest path search, and others.

![Graph](doc/image/junction/WithoutLegend.png)

## Documenration

Index of concepts behind the module and tutorials you may find [her](doc/version.eng/README.md).

## Sample

``` js
require( '..' );
let _ = wTools;

/*
This example shows how to create a simple graph.
Graph :: set of nodes( vertices ) and set of edges or arcs connecting some or all nodes.
*/

/*
Define a graph of arbitrary structure.
Strcuture of nodes is arbitrary. It could even be instance of a primitive type.
Group of nodes should have handlers which should return lists of neighbour nodes.
*/

var a = { name : 'a', nodes : [] } // 1
var b = { name : 'b', nodes : [] } // 2
var c = { name : 'c', nodes : [] } // 3

// declare lists neighbour nodes

a.nodes.push( b ); // add edge between nodes a and b
b.nodes.push( c ); // add edge between nodes b and c

/* declare the graph */

var sys = new _.graph.AbstractGraphSystem(); // declare sysyem of graphs
var group = sys.groupMake(); // declare group of nodes
group.nodesAdd([ a, b, c ]); // add nodes to the group

console.log( group.nodesExportInfo() ); // print information about nodes relation

/*
    1 : 2
    2 : 3
    3 :
*/
```

### Try out from the repository

```
git clone https://github.com/Wandalen/wgraphbasic
cd wgraphbasic
will .npm.install
node sample/trivial/Sample.s
```

Make sure you have utility `willbe` installed. To install willbe: `npm i -g willbe@stable`. Willbe is required to build of the module.

### To add to your project

```
npm add 'wgraphbasic@stable'
```

`Willbe` is not required to use the module in your project as submodule.

