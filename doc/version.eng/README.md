
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
    Even graph - a graph each node of which has an even number of edges. Only even graph has cycle decomposition.
</details>

<details>
  <summary><a href="./concept/Graph.md">
    Complete graph
  </a></summary>
    Complete graph - a graph each node of which has an edge to each other node of which.
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
    A subgraph of a graph is another graph formed from a subset of vertices and edges of the original graph.
</details>

<details>
  <summary><a href="concept/Subgraph.md#Induced-subgraph">
    Induced subgraph
  </a></summary>
    An induced subgraph of a graph is another graph formed from a subset of vertices of the original graph and all edges of the original graph, which have both endpoints in the induced subgraph.
</details>

<details>
  <summary><a href="concept/Subgraph.md#Clique">
    Clique
  </a></summary>
    Clique is an induced subgraph which is complete.
</details>

<details>
  <summary><a href="concept/Subgraph.md#Spanning-subgraph">
    Spanning subgraph
  </a></summary>
    The spanning subgraph of a graph is another graph formed from all vertices of the original graph.
</details>

<details>
  <summary><a href="concept/Subgraph.md#Walk--Chain">
    Walk ~ Chain
  </a></summary>
    The walk is a subgraph sequentially connected vertices of the original graph. Also called chain. A walk can have more than one correspondence of a node of the original graph. A walk can have more than one correspondence of an edge of the original graph. In other words both vertices and edges of the original graph can be repeated in the walk.
</details>

<details>
  <summary><a href="concept/Subgraph.md#Open-walk">
    Open walk
  </a></summary>
    The open walk is a walk that does not have cycle decomposition.
</details>

<details>
  <summary><a href="concept/Subgraph.md#Closed-walk">
    Closed walk
  </a></summary>
    The closed walk is a walk which has cycle decomposition.
</details>

<details>
  <summary><a href="concept/Subgraph.md#Trail">
    Trail
  </a></summary>
    The trail is a walk each edge of the original graph of which has one or none corresponding edge in the walk. In other word, vertices of the original graph can be repeated in the trail, but not edges.
</details>

<details>
  <summary><a href="concept/Subgraph.md#Open-trail">
    Open trail
  </a></summary>
    The open trail is a trail that does not have cycle decomposition.
</details>

<details>
  <summary><a href="concept/Subgraph.md#Closed-trail--Circuit">
    Closed trail ~ Circuit
  </a></summary>
    The closed trail is a trail that has cycle decomposition. The closed trail is also called circuit.
</details>

<details>
  <summary><a href="concept/Subgraph.md#Euler-trail">
    Euler trail
  </a></summary>
    Euler trail - trail that visits every edge exactly once.
</details>

<details>
  <summary><a href="concept/Subgraph.md#Path">
    Path
  </a></summary>
    The path is a walk each edge of the original graph of which has one or none corresponding edge in the walk and each vertex of the original graph of which has one or none corresponding vertex in the walk. In other words, neither vertices nor edges of the original graph can be repeated in the path.
</details>

<details>
  <summary><a href="concept/Subgraph.md#Open-path">
    Open path
  </a></summary>
    The open path is a path that does not have cycle decomposition.
</details>

<details>
  <summary><a href="concept/Subgraph.md#Closed-path--Cycle">
    Closed path ~ Cycle
  </a></summary>
    A closed path is a path that has cycle decomposition. A closed path is also called circuit.
</details>

<details>
  <summary><a href="concept/Subgraph.md#diameter">
    Diameter
  </a></summary>
    The diameter of a graph is the longest of the shortest path of the graph.
</details>

<details>
  <summary><a href="concept/Subgraph.md#Neighborhood">
    Neighborhood
  </a></summary>
    The neighborhood is an induced subgraph of the graph formed by all nodes adjacent to v.
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
    Cycle decomposition - graph decomposition, each element of which is a cycle. Cycle decomposition possible only for even graphs.
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
    A node connected to all nodes of the graph.
</details>

<details>
  <summary><a href=".">
    Terminal node ~ Pendant node ~ Leaf node
  </a></summary>
    A terminal node is a node with the degree of one.
</details>

<details>
  <summary><a href=".">
    Node degree
  </a></summary>
    The node degree of a node is the total number of incoming and outgoing edges of the node.
</details>

<details>
  <summary><a href=".">
    Indegree
  </a></summary>
    Indegree of a node is a number of incoming edges.
</details>

<details>
  <summary><a href=".">
    Outdegree
  </a></summary>
    The outdegree of a node is a number of outgoing edges.
</details>

<details>
  <summary><a href=".">
    Center node
  </a></summary>
    Center node - node with minimum remoteness. All diameters go through the center. A graph has at most two centers.
</details>

<details>
  <summary><a href=".">
    Centroid node
  </a></summary>
    Centroid node - a node of the graph when removed minimizes the largest remaining component. A graph has at most two centroids.
</details>

###### Nodes

<details>
  <summary><a href=".">
    Connected nodes
  </a></summary>
    Nodes are connected if they have an edge connecting both of them.
</details>

<details>
  <summary><a href=".">
    Reachable node
  </a></summary>
    Node v is reachable from u if there is a path from v to u.
</details>

<details>
  <summary><a href=".">
    Neigbour nodes
  </a></summary>
    Neighbor nodes - nodes that are connected to the node.
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
    Depth-first search - widely spread algorithm to traverse a graph in a depth-first manner.
</details>

<details>
  <summary><a href=".">
    Breadth-first search ~ BFS
  </a></summary>
    Breadth-first search - widely spread algorithm to traverse a graph in a breadth-first manner.
</details>

<details>
  <summary><a href=".">
    Strongly connected components ~ SCC
  </a></summary>
    The strongly connected components of a directed graph form a partition into subgraphs that are themselves strongly connected.
</details>

<details>
  <summary><a href="concept/StrategyRevisiting.md">
    Revisiting strategy
  </a></summary>
    The revisiting strategy of a search algorithm is a strategy to handle multiple encountering of a node.
</details>

<details>
  <summary><a href="concept/StrategyAllSiblings.md">
    Siblings revisiting strategy
  </a></summary>
    The siblings strategy of a search algorithm is a strategy to handle multiple edges that connect pares of a parent and a child nodes.
</details>

<details>
  <summary><a href="concept/StrategyAllVariants.md">
    Junction revisiting strategy
  </a></summary>
    The junction revisiting strategy of a search algorithm is a strategy to handle junction nodes.
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
    Topological sort - algorithm of the linear ordering of a DAG.
</details>

<details>
  <summary><a href=".">
    Topological ordering
  </a></summary>
    Topological ordering - an array of linearly ordered elements of DAG.
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
    Distance layers - an array of sets of nodes. The first layer has roots or zero-distance sets of nodes. The second layer has nodes on distance one from roots. And so on. BFS produces distance layers.
</details>

## Tutorials

<details><summary><a href="./tutorial/Abstract.md">
      Abstract
  </a></summary>
  General information about the module GraphBasic.
</details>
