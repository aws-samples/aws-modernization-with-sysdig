+++
title = "Edit and Build"
chapter = false
weight = 10
+++

## Directory Tree
Directory of artifacts you will add, change, delete during the course of building a workshop.
```bash
  /
   |-content
   |---_index.md
   |-static
   |---images
   |config.toml
 
```

## Editing 
Hugo uses markdown to generate static html pages.  This makes it easier to create a web based workshop as all you need to do is create documents using markdown and Hugo will create the pretty html for you.  For additional information on markdown, visit the learn theme documentation page https://learn.netlify.com/en/cont/markdown/

#### config.toml file
Start by editing the config.toml file. Only the Title needs to be edited at this time.
```bash
baseURL = "/"
languageCode = "en-US"
defaultContentLanguage = "en"

title = "AWS Modernization Workshop Sample"
theme = "hugo-theme-learn"
metaDataFormat = "yaml"
defaultContentLanguageInSubdir= true
```
#### Start Hugo Server
```bash
hugo server
```
> Navigate to localhost:1313 in your browser to see the sample site

#### Content editing
Now lets start editing content. Hugo uses the content stored in `content` to build web pages.  If you look under the directory there is a file _index.md.  This is the starting point of the documentation and is the equivalent of index.html.  Each folder becomes the high level navigation.  Each of the folders and files are prefixed with a number, which is there for visual ordering only and does not have an effect on the actual html or workshop order.  

Start with `/content/_index.md` 
Each file has what Hugo calls front matter.  This is basically metadata that Hugo uses when generating the files.  Here is an example, note the Title and weight fields.  Weight controls the ordering, lower number the higher the order.  Front matter weight is what actually orders the content in Hugo, prefixing numbers to files such as 1_my_content.md is only for visual ordering in your IDE/directory listing.

```bash
---
title: "Main Page"
chapter: true
weight: 1
---
```

**Edit** The title and the text below the 3 dashes, now **Save** If everything went well the browser should refresh with the changes you have just make.

#### Edit folder names and files
The folder names are stubs and should be edited to make clear what type of content is stored in them.  The file `_index.md` within each folder sets the order using the weight front matter, and the name that appears in the left navigation pane.  Once again names are prefixed with a number only to visually sort, the `weight` is what really determines the ordering.

{{% notice tip %}}
When creating additional sections or pages, copy the files and folders from another section, rename and edit.  
{{% /notice %}}

#### Samples and building blocks
In the repo https://github.com/aws-samples/aws-modernization-workshop-sample there are several examples and content that you can copy and reuse in your workshop. 
* content directory - Various building blocks such as an account and Cloud9 instance.  Don't forget the images in static/images
* code-samples directory is CloudFormation, CodeBuild, and other samples.  The CloudFormation folder is available publicly at https://modernization-workshop-bucket.s3-us-west-2.amazonaws.com/cfn/ so you can leverage existing templates for nesting and one-click deployments. 

Feel free to leverage these samples in your solution.  **Note** this is a workshop so samples are not meant to be best practice, but more for educational purposes only.  So if your workshop uses an RDS instance there is no reason to setup replication, backups, and everything else that goes along with making a robust solution, this is of course unless your workshop is on building robust fault tolerant solutions ;)

#### Scripts, Artifacts, custom CloudFormation templates
If your workshop includes custom scripts, artifacts, etc... you should save them to the content folder where they will be needed.  As an example, if I have a getting_started.sh that is used in the First Section, I would place that script in `content/10_first_section`

#### Special markdown samples
* Markdown cheat sheet https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet
* Learn theme markdown https://learn.netlify.app/en/cont/markdown/
* Menu extras and shortcuts https://learn.netlify.app/en/cont/menushortcuts/
* Using Font Awesome Emoji's <i class="fas fa-heart"></i> https://learn.netlify.app/en/cont/icons/ to help your page pop <i class="fas fa-glass-cheers"></i>




