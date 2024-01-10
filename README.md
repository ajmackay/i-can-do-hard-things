# README

## RENV

1.  When you finish a blog post, call <code>renv::snapshot()</code>
2.  Copy the renv.lock file (located in working directory) into the directory of the blog post
3.  In the blog post, add the following code chunk at the top of the file (after the YAML header):

```{#| echo: false}
#| results: 'hide'
renv::use(lockfile = "renv.lock")
```

This will ensure when you render the blog, each post will render the packages with the version in which they were originally created with.

## Posting a Blog Post
