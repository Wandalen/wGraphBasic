
## Concepts

###### Graph

<details>
  <summary><a href="./concept/Graph.md">
    Graph
  </a></summary>
    Set of nodes and set of edges or arcs connecting some or all nodes.
</details>

<details>
  <summary><a href="./concept/Graph.md">
    Even graph
  </a></summary>
    Even graph - a graph each node of which has even number of edges. Only even graph has cycle decomposition.
</details>

<details>
  <summary><a href="./concept/Graph.md">
    Complete graph
  </a></summary>
    Complete graph - a graph each node of which has edge to each other node of which.
</details>

<details>
  <summary><a href=".">
    Directed acycled graph ~ DAG
  </a></summary>
    Directed acycled graph - directed graph with no cycles.
</details>

<details>
  <summary><a href=".">
    Strongly connected graph
  </a></summary>
    Strongly connected graph - graph in which every node is reachable from any other node.
</details>

###### Subgraph

<details>
  <summary><a href="concept/Subgraph.md#Subgraph">
    Subgraph
  </a></summary>
    Subgraph of a graph is another graph formed from subset of vertices and edges of the original graph.
</details>

<details>
  <summary><a href="concept/Subgraph.md#Induced-subgraph">
    Induced subgraph
  </a></summary>
    Induced subgraph of a graph is another graph formed from subset of vertices of original graph and all edges of the original graph which have both endpoints in the induced subgraph.
</details>

<details>
  <summary><a href="concept/Subgraph.md#Clique">
    Clique
  </a></summary>
    Clique is induced subgraph which is complete.
</details>

<details>
  <summary><a href="concept/Subgraph.md#Spanning-subgraph">
    Spanning subgraph
  </a></summary>
    Spanning subgraph of a graph is another graph formed from all vertices of the original graph.
</details>

<details>
  <summary><a href="concept/Subgraph.md#Walk--Chaing">
    Walk ~ Chain
  </a></summary>
    Walk is a subgraph sequentially connected vertices of original graph. Also called chain. Walk can have more than one correspondence of a node of the original graph. Walk can have more than one correspondence of an edge of the original graph. In other word both vertices and edges of the original graph can be repeated in the walk.
</details>

<details>
  <summary><a href="concept/Subgraph.md#Open-walk">
    Open walk
  </a></summary>
    Open walk is a walk which does not have cycle decomposition.
</details>

<details>
  <summary><a href="concept/Subgraph.md#Closed-walk">
    Closed walk
  </a></summary>
    Closed walk is a walk which has cycle decomposition.
</details>

<details>
  <summary><a href="concept/Subgraph.md#Trail">
    Trail
  </a></summary>
    Trail is a walk each edge of original graph of which has one or none corresponding edge in the walk. In other word vertices of the original graph can be repeated in the trail, but not edges.
</details>

<details>
  <summary><a href="concept/Subgraph.md#Open-trail">
    Open trail
  </a></summary>
    Open trail is a trail which does not have cycle decomposition.
</details>

<details>
  <summary><a href="concept/Subgraph.md#Closed-trail--Circuit">
    Closed trail ~ Circuit
  </a></summary>
    Closed trail is a trail which has cycle decomposition. Closed trail is also called circuit.
</details>

<details>
  <summary><a href="concept/Subgraph.md#Path">
    Path
  </a></summary>
    Path is a walk each edge of original graph of which has one or none corresponding edge in the walk and each vertex of original graph of which has one or none corresponding vertex in the walk. In other word neither vertices nor edges of the original graph can be repeated in the path.
</details>

<details>
  <summary><a href="concept/Subgraph.md#Open-path">
    Open path
  </a></summary>
    Open path is a path which does not have cycle decomposition.
</details>

<details>
  <summary><a href="concept/Subgraph.md#Closed-path--Cycle">
    Closed path ~ Cycle
  </a></summary>
    Closed path is a path which has cycle decomposition. Closed path is also called circuit.
</details>

<details>
  <summary><a href="concept/Subgraph.md#diameter">
    Diameter
  </a></summary>
    Diameter of a graph is the longest of the shortest path of the graph.
</details>

<details>
  <summary><a href="concept/Subgraph.md#Neighborhood">
    Neighborhood
  </a></summary>
    Neighborhood is an enduced subgraph of the graph, formed by all nodes adjacent to v.
</details>

<details>
  <summary><a href="concept/Subgraph.md#Graph-decomposition">
    Graph decomposition
  </a></summary>
    Graph decomposition - partitioning of edges of a graph.
</details>

<details>
  <summary><a href="concept/Subgraph.md#Cycle-decomposition">
    Cycle decomposition
  </a></summary>
    Cycle decomposition - graph decomposition each element of which is cycle. Cycle decomposition possible only for even graph.
</details>

###### Node

<details>
  <summary><a href=".">
    Sink node
  </a></summary>
    Node with zero outdegree.
</details>

<details>
  <summary><a href=".">
    Source node
  </a></summary>
    Node with zero indegree.
</details>

<details>
  <summary><a href=".">
    Universal node
  </a></summary>
    Node connected to all nodes of the graph.
</details>

<details>
  <summary><a href=".">
    Terminal node ~ Pendant node ~ Leaf node
  </a></summary>
    node with degree of one.
</details>

<details>
  <summary><a href=".">
    Node degree
  </a></summary>
    Node degree of a node is total number of incoming and outgoing edges of the node.
</details>

<details>
  <summary><a href=".">
    Indegree
  </a></summary>
    Indegree of a node is number of incoming edges.
</details>

<details>
  <summary><a href=".">
    Outdegree
  </a></summary>
    Outdegree of a node is number of outgoing edges.
</details>

<details>
  <summary><a href=".">
    Center node
  </a></summary>
    Center node - node with minimum remoteness. All diameters go though the center. A graph has at most 2 centers.
</details>

<details>
  <summary><a href=".">
    Centroid node
  </a></summary>
    Centroid node - a node of the graph when removed minimizes largest remaining component. A graph has at most 2 centroids.
</details>

###### Nodes

<details>
  <summary><a href=".">
    Connected nodes
  </a></summary>
    Nodes are connected if them have edge connecting both of them.
</details>

<details>
  <summary><a href=".">
    Reachable node
  </a></summary>
    node v is reachable from u if there is a path from v to u.
</details>

<details>
  <summary><a href=".">
    Neigbour nodes
  </a></summary>
    Neigbour nodes - nodes which are connected to the node.
</details>

<details>
  <summary><a href=".">
    Distance between nodes
  </a></summary>
    Distance between nodes - minimal number of edges to get from one given node to another given node.
</details>

<details>
  <summary><a href=".">
    Node remoteness
  </a></summary>
    Node remoteness - is its distance from the furthest node.
</details>

###### Edges

<details>
  <summary><a href=".">
    Incident edges
  </a></summary>
    Incident edges of the node, are edges connected to the node.
</details>

###### Algorithmic

<details>
  <summary><a href=".">
    Depth-first search ~ DFS
  </a></summary>
    Depth-first search - widely spread algorithm to traverse a graph in depth-first manner.
</details>

<details>
  <summary><a href=".">
    Breadth-first search ~ BFS
  </a></summary>
    Breadth-first search - widely spread algorithm to traverse a graph in breadth-first manner.
</details>

<details>
  <summary><a href=".">
    Strongly connected components ~ SCC
  </a></summary>
    The strongly connected components of an directed graph form a partition into subgraphs that are themselves strongly connected.
</details>

<details>
  <summary><a href="concept/StrategyRevisiting.md">
    Revisiting strategy
  </a></summary>
    The revisiting strategy of a search algorithm is a strategy to handle multiple encountering of a node.
</details>

<details>
  <summary><a href=".">
    Low-link value
  </a></summary>
    Low-link value - smallest node id reachable from the node.
</details>

<details>
  <summary><a href=".">
    Topological sort
  </a></summary>
    Topological sort - algorithm of linear ordering of a DAG.
</details>

<details>
  <summary><a href=".">
    Topological ordering
  </a></summary>
    Topological ordering - array of linearly ordered elements of DAG.
</details>

<details>
  <summary><a href="concept/Junction.md">
    Junction
  </a></summary>
    The junction is a relation between two or more nodes of a graph, making algorithms treat those distinct nodes as the same node.
</details>

<details>
  <summary><a href=".">
    Distance layers
  </a></summary>
    Distance layers - array of sets of nodes. First layer has roots or zero-distance set of nodes. Second layer has nodes on distance one from roots. And so on. BFS produce distance layers.
</details>

## Tutorials

<details><summary><a href="./tutorial/Abstract.md">
      Abstract
  </a></summary>
  General information about the module GraphBasic.
</details>
