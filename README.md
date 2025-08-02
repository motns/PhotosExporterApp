# Photos Exporter App

A MacOS App used to replicate the local Apple Photos library on MacOS into a target folder by:
* Mirroring Assets, Resources, Albums and Folders into a SQLite database in the export folder
* Copying all Resources into the export folder, organised by date and location (where available)
* Recreating the Album and Folder structures using symlinks pointing to the copied Resources

Uses [PhotosExporterLib.swift](https://github.com/motns/PhotosExporterLib.swift) internally.
