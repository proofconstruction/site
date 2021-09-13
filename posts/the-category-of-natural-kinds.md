---
title: The Category of Natural Kinds
date: 2021-09-13
---

This is part 3 of the series on natural kinds. The previous post is [here](./natural-kinds-defined.html).

Having established what natural kinds *are*, we're ready to examine maps between them and lift our discussion to the categorical setting. This short post establishes the categorical nature of natural kinds and maps between them. 

# Onward
In the context of natural kinds, *implication* (remember, there's a logic here!) is taken to be the species-genus relation: for natural kinds $K_1, K_2$, to say $K_1 \Rightarrow K_2$ is to say $K_1$ is *a species of* $K_2$.

This is formalized as follows:

For kinds $K_1 = (A_1, X_1)$ and $K_2 = (A_2, X_2)$, saying that $K_1$ is *a species of* $K_2$ amounts to:

- $(A_1 \subseteq A_2)$
- $(X_2 \subseteq X_1)$

That is,

- every $K_1$ individual is also a $K_2$ individual
- every $K_2$ trait is also a $K_1$ trait.

We have the following theorem (T1), for natural kinds $K_1 = (A_1, X_1)$ and $K_2 = (A_2, X_2)$:

$K_1 \Rightarrow K_2$ iff $A_1 \subseteq A_2$ and $X_2 \subseteq X_1$.

# Upward

Natural kinds, together with the species-genus relation, form a category:

Let $K = (A,X)$ be any natural kind.

### Identity Arrow
By reflexivity of the subset relation, $A \subseteq A$ and $X \subseteq X$, so $X \Rightarrow X$.

### Arrow Composition
Now let $K_1 = (A_1, X_1)$, $K_2 = (A_2, X_2)$, and $K_3 = (A_3, X_3)$ be natural kinds and suppose $K_1 \Rightarrow K_2$ and $K_2 \Rightarrow K_3$.

By the theorem (T1) in the previous section, $K_1 \Rightarrow K_2$ iff $A_1 \subseteq A_2$ and $X_2 \subseteq X_1$, and $K_2 \Rightarrow K_3$ iff $A_2 \subseteq A_3$ and $X_3 \subseteq X_2$.

If $A_1 \subseteq A_2$ and $A_2 \subseteq A_3$, then $A_1 \subseteq A_3$, and if $X_3 \subseteq X_2$ and $X_2 \subseteq X_1$, then $X_3 \subseteq X_1$, so $K_1 \Rightarrow K_3$ on the assumption that $K_1 \Rightarrow K_2$ and $K_2 \Rightarrow K_3$.

The subset relation is associative, so evidently this composition is too.

These facts tell us that natural kinds with the species-genus implication form a category.

In the next post, we'll examine some of the categorical features of natural kinds, with an eye to building bridges to other parts of logic and mathematics.
