# Check for updated demo files in GitHub organizations and repositories

## Update tool

### </a>Prepare

#### <a name="prepare"> Initial content for `updatestatus.json` 

The `updatestatus.json` file needs to exist before `update.dart` is executed.
`update.dart` checks the organizations listed in `updatestatus.json`.
As minimal content to start with could look like:
 
```json
 {
   "organizations": [
     {
       "organization": "PolymerElements",
       "organization": "GoogleWebComponents"
     }
   ]
}     
```     

This is actually what was used for this project.

#### `.github_token`

`update.dart` makes a lot of GitHub API calls. Without authentication GitHub
blocks after a few calls and `update.dart` fails.
When a `tool/.github_token` file with a valid token is available this token will
be used to avoid running into this limitation.
 
See [Personal API tokens](https://github.com/blog/1509-personal-api-tokens) and 
[Creating an access token for command-line use](https://help.github.com/articles/creating-an-access-token-for-command-line-use/)
for guidance. 


### <a name="add_organization"></a>Add an additional GitHub organization

To add an additional GitHub organization to check for element demo updates just
add a new organization to the `updatestatus.json` file like shown in 
[Prepare](#prepare)

```json
 {
   "organizations": [
     {
       "organization": "PolymerElements",
       "organization": "GoogleWebComponents"
       "repositories": [
          {
            "repository": "demos",
            "files": [],
            "skip": false,
            "change": "RepositoryChange.none"
          }
          // more repositories ...
       ],
       "organization": "SomeOtherOrganization",
     }
   ]
}     
```    

### Exclude repositories from update checks

When `update.dart` is run it creates an entry for each found repository in each
listed GitHub organization like shown in 
[Add an additional GitHub organization](#add_organization)

Just change the value from `"skip": false` to `"skip": true`
 
 
### Maintenance
 
To ensure `update.dart` is able to show changes, only commit changes to the 
`updatestatus.json` file, that are actually ported to the Dart demos. 

If `update.dart` is run twice successively, the changes from the first run are
overridden.   
Reverting to a previous version of `updatestatus.json` and then running 
`update.dart` again allows to show recent changes.  


### The `updatestatus.json` file

`update.dart` reads `updatestatus.json`, loads information about repositories 
found in the listed GitHub organizations and adds or updates 
`updatestatus.json` to reflect the current status of the demo files in these
repositories.

The top level is a list of GitHub organizations to check.

```json
{
  "organizations": [
    {
      "organization": "PolymerElements"
    }
  ]
}
```
      
For each organization the list of found repositories is maintained       

```
{
  "organizations": [
    {
      "organization": "PolymerElements",
      "repositories": [
        {
          "repository": "app-layout-templates",
          "files": [],
          "skip": false,
          "change": "RepositoryChange.none"
        },
        {
          "repository": "chartjs-element",
          "files": [
            {
              "file": "demo/index.html",
              "sha": "d10421cce928ca8a517ed9871ad7724010a66de2",
              "commit_sha": "ec53a880a602f616cd2112c5f9adc9d92c281bba",
              "change": "FileChange.none",
              "compare_view": "https://github.com/PolymerElements/chartjs-element/blob/master/demo/index.html"
            }
          ],
          "skip": false,
          "change": "RepositoryChange.none"
        }
      ]
    }
  ]
}
```

The repository **app-layout-templates** seems not to contain any demo file 
because the `files` property is an empty list. For the **chartjs-element** the
file `demo/index.html` was found.

For **app-layout-templates** it could make sense to set `skip` to `false` but 
it doesn't really matter in this caes. When no files are found, nothing happens.
If `skip` is set to `false` you need to revert it to `true` manually to make 
`update.dart` check this repository again for changes.

The `change` property of the repository shows whether the repo was newly 
discovered since the last check (`RepositoryChange.add`) or if it was removed 
(`RepositoryChange.delete`, these values are just the serialized enum values of 
the `RepositoryChange` enum in `update.dart`). Renames are not recognized and 
result in both. This also doesn't inform about changes of files in this 
repository.

Then `change` property of the file shows whether the file was added, removed, or
modified since the last check (the values are just the serialized enum values 
of the `FileChange` enum in `update.dart`). 
The `sha` value is used to check for changes. No actual file content is 
compared.
If the file was changed since the last check, the previous `sha` is moved to 
`old_sha` and the new value again stored as `sha`.
Removing `sha` makes `update.dart` treat this file as changed at the next run. 

The `commit_sha` references the last commit in the default branch.
When a change to one of the demo files was recognized, `commit_sha` is moved to
`old_commit_sha` and the last commit sha is stored again as `commit_sha`.
The `commit_sha` property could/should be moved to the repository because it 
isn't maintained on file level by GitHub either. 

`commit_sha` is tracked to be able to generate the url for `compare_view`
If the file is new, the url in `compare_view` just shows the content of the file
in GitHub.
If the file was already tracked and was modified since the last check, 
`compare_view` opens a page that shows the diff between the previous commit 
(`old_commit_sha` after the check) and the current commit (`commit_sha` after 
the check) on GitHub. This view also includes changed non-demo files because
GitHub doesn't provide more fine-grained control.

There is also a top-level `transformers` property added (at the bottom of the 
file). This allowed to just copy the `entry_point` values to `pubspec.yaml` 
(with a bit of manipulation because the JSON format doesn't allow the values
to be formatted exactly like `pubspec.yaml` requires it (no multiline string 
support in JSON).


 
## Status viewer

The files `status.dart`, `status.html`, `update_status.dart`, 
`update_status.html` contain the implementation of the update status viewer 
tool. 

The entry_point is the `status.html` file.

It loads the `updatestatus.json` file and shows the content in three lists.
`Organizations`, `Repositories`, `Files` while `Repositories` only shows
the entries related to the item selected in `Organizations` and `Files` only 
shows the entries related to the item selected in `Repository`.

The toolbar above the `Repositories` allows to filter repositories by 
"not filtered", "new repositories only", "deleted repositories only" and 
"repositories with modified files only".
On the left of the items in the `Repositories` and `Files` list an icon 
indicates whether the repository was added or removed or whether the file
was added, removed or modified.
   
The file items are links to the GitHub file view or, if modified since the last
update check, a link to a compare view of the previous and the current commit.     
  


 
 
 
       

