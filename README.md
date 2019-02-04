
# wAbstractGraph [![Build Status](https://travis-ci.org/Wandalen/wAbstractGraph.svg?branch=master)](https://travis-ci.org/Wandalen/wAbstractGraph) [![Build Status](https://ci.appveyor.com/api/projects/status/github/Wandalen/wabstractgraph)](https://ci.appveyor.com/project/Wandalen/wabstractgraph)

Collection of abstract data structures and algorithms to process graphs. The module does not bound to any specific format of a graph, so providing adapters toy may use it with anyone. It implements depth-first search, breadth-first search, extracting strongly connected components, topological sort, shortest path search, and others.

## Glossary

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

## Try out
```
npm install
node sample/Sample.s
```

<<<<<<< HEAD


=======
>>>>>>> 58e2425659eb9f6fdbdb3955f40477fc0090147e

