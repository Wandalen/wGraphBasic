
# wAbstractGraph [![Build Status](https://travis-ci.org/Wandalen/wAbstractGraph.svg?branch=master)](https://travis-ci.org/Wandalen/wAbstractGraph) [![Build Status](https://ci.appveyor.com/api/projects/status/github/Wandalen/wabstractgraph)](https://ci.appveyor.com/project/Wandalen/wabstractgraph)

Collection of abstract data structures and algorithms to process graphs. The module does not bound to any specific format of a graph, so providing adapters toy may use it with anyone. It implements depth-first search, breadth-first search, extracting strongly connected components, topological sort, shortest path search, and others.

## Concepts

**Graph** :: set of nodes and set of edges or arcs connecting some or all nodes. </br>
**Incident edges** :: of the node, are edges connected to the node. </br>
**Connected nodes** :: nodes are connected if them have edge connecting both of them. </br>
**Reachable node** :: node v is reachable from u if there is a path from v to u. </br>
**DFS** :: depth-first search. </br>
**BFS** :: breadth-first search. </br>
**DAG** :: directed acycled graph. </br>
**SCC** :: Strongly connected components. </br>
**Node degree** :: total number of incoming and outgoint edges of the node. </br>
**Indegree** :: of the node is number of incoming edges. </br>
**Outdegree** :: of the node is number of outgoing edges. </br>
**Sink node** :: node with zero outdegree. </br>
**Source node** :: node with zero indegree. </br>
**Universal node** :: node connected to all nodes of the graph. </br>
**Terminal node** :: **pendant node** :: **leaf node** :: node with degree of one. </br>
**Neighborhood** :: is an enduced subgraph of the graph, formed by all nodes adjacent to v. </br>
**Neigbour nodes** :: nodes which are connected to the node. </br>
**Low-link value** of a node :: smallest node id reachable from the node. </br>
**Topological ordering** :: linear ordered DAG. </br>
**Topological sort** :: algorithm of linear ordering of DAG. </br>
**Distance between nodes** :: minimal number of edges to get from one given node to another given node. </br>
**Distance layers** :: array of arrays of nodes. First layer has origin or zero-distance set of nodes. Second layer has nodes on distance one from origin. And os on. </br>

## Sample

```
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

