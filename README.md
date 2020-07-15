
# module::GraphBasic [![Status](https://github.com/Wandalen/wGraphBasic/workflows/Publish/badge.svg)](https://github.com/Wandalen/wGraphBasic/actions?query=workflow%3APublish) [![experimental](https://img.shields.io/badge/stability-experimental-orange.svg)](https://github.com/emersion/stability-badges#experimental)

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

## Try out
```
npm install
node sample/Sample.s
```
