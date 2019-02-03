
# wAbstractGraph [![Build Status](https://travis-ci.org/Wandalen/wAbstractGraph.svg?branch=master)](https://travis-ci.org/Wandalen/wAbstractGraph) [![Build Status](https://ci.appveyor.com/api/projects/status/github/Wandalen/wabstractgraph)](https://ci.appveyor.com/project/Wandalen/wabstractgraph)

Collection of abstract data structures and algorithms to process graphs. The module does not bound to any specific format of a graph, so providing adapters toy may use it with anyone. It implements depth-first search, breadth-first search, extracting strongly connected components, topological sort, shortest path search, and others.

**Graph** :: set of nodes and set of edges or arcs connecting some or all nodes.

**Incident edges** :: of the node, are edges connected to the node.

Connected nodes :: nodes are connected if them have edge connecting both of them.
Reachable :: node v is reachable from u if there is a path from v to u.
DFS :: depth-first search.
BFS :: breadth-first search.
DAG :: directed acycled graph.
SCC :: Strongly connected components.
Node degree :: total number of incoming and outgoint edges of the node.
Indegree :: of the node is number of incoming edges.
Outdegree :: of the node is number of outgoing edges.
Sink node :: node with zero outdegree.
Source node :: node with zero indegree.
Universal node :: node connected to all nodes of the graph.
Terminal node :: pendant node :: leaf node :: node with degree of one.
Neighborhood :: is an enduced subgraph of the graph, formed by all nodes adjacent to v.
Neigbour nodes :: nodes which are connected to the node.
Low-link value of a node :: smallest node id reachable from the node.
Topological ordering :: linear ordered DAG.
Topological sort :: algorithm of linear ordering of DAG.
Distance between nodes :: minimal number of edges to get from one given node to another given node.
Distance layers :: array of arrays of nodes. First layer has origin or zero-distance set of nodes. Second layer has nodes on distance one from origin. And os on.

## Try out
```
npm install
node sample/Sample.s
```

