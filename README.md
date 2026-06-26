# tech-blog
![](https://github.com/hot377/tech-blog/actions/workflows/publish.yml/badge.svg)

This repository is used to manage and publish articles on [Zenn](https://zenn.dev/) and [Qiita](https://qiita.com/). Primarily, it's a place to share the code I've created and record what I've learned. This serves as a personal archive from which others can also learn.

The setup of this repository is based on the great work by [@C-Naoki](https://github.com/C-Naoki): the [zenn-archive](https://github.com/C-Naoki/zenn-archive) template and the [zenn-qiita-sync](https://github.com/C-Naoki/zenn-qiita-sync) action, which synchronizes Qiita articles from Zenn articles. Many thanks to the original author.

## Directory Structure

- `.github/workflows/`: It contains GitHub Actions workflows.
- `articles/`: It contains Zenn articles written in Markdown format.
- `books/`: It contains Zenn books. The structure should follow the Zenn book guidelines.
- `images/`: It contains images used in articles and books.
- `qiita/`: It contains Qiita articles, which are automatically generated from Zenn articles by a GitHub Actions workflow (see `.github/workflows/publish.yml`).

## Getting Started
Run the development server:
```bash
npx zenn preview
```
- Open [http://localhost:8000](http://localhost:8000) with your browser to see the result.

When you want to write a new article:
```bash
npx zenn new:article --slug 記事のスラッグ --title タイトル --type idea --emoji ✨
```
- The above command's options are as follows:
    - `--slug`: The slug of the article. This needs to be a combination of `a-z0-9`, `hyphen (-)`, and `underscore (_)` with 12 to 50 characters.
    - `--title`: The title of the article.
    - `--type`: The type of the article. The options should be chosen from `tech`, `idea`.
    - `--emoji`: The emoji of the article.

## License

This repository contains both source code and written articles, which are licensed separately:

- **Code** (code snippets in articles, scripts, and configuration) is licensed under the [MIT License](LICENSE).
- **Articles and images** (the content under `articles/`, `books/`, and `images/`) are licensed under [Creative Commons Attribution 4.0 International (CC BY 4.0)](https://creativecommons.org/licenses/by/4.0/). See [LICENSE-CONTENT](LICENSE-CONTENT).

You are free to reuse the code under the terms of the MIT License, and to share or adapt the articles as long as you give appropriate credit.
