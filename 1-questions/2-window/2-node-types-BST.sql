/*
Question Link: https://www.hackerrank.com/challenges/binary-search-tree-1/problem?isFullScreen=true

You are given a table, BST, containing two columns: N and P, where N represents the value of a node in Binary Tree, and P is the parent of N.

Write a query to find the node type of Binary Tree ordered by the value of the node. Output one of the following for each node:

Root: If node is root node.
Leaf: If node is leaf node.
Inner: If node is neither root nor leaf node.
*/

-- My brute force solution:
SELECT
    this.N, 
    CASE 
        WHEN this.P IS NULL THEN 'Root'
        WHEN (SELECT COUNT(indent.N) FROM BST indent WHERE indent.P = this.N) > 0 THEN 'Inner'
        ELSE 'Leaf'
    END AS node_type
FROM BST this
ORDER BY this.N;