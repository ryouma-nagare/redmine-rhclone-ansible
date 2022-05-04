# redmine-rhelclone-ansible


## 概要
「最小限のインストール」でインストールした直後の CentOS 7/RockyLinux8/MiracleLinux8 に Redmine5.0 をインストールするためのplaybookです。

## MW等の構成

* OS：CentOS 7/RockyLinux8/MiracleLinux8
* DB：PostgreSQL 14
* APサーバ：unicorn
* Webサーバ：apache2
* Ruby：feedforceから取得(CentOS7のみ)
* Redmine：5.0

ビルドなしでインストールできるように選んでいます。

## 環境依存の設定

#### MW設定
- `group_vars/redmine`
    - データベース設定
        - `postgres.db_name` にデータベース名
        - `postgres.db_user` にデータベース接続のユーザ名
        - `postgres.db_pass` にデータベース接続のパスワード
    - Redmine設定
        - `redmine.mail_server.domain` にメールのドメイン

#### ssh設定
- `inventory/hosts`
    - `ansible_host` に サーバのIP
    - `ansible_ssh_user` にログインするユーザ名
	- `ansible_ssh_pass` にログインするユーザのパスワード
	- `ansible_sudo_pass` にログインするユーザのパスワード

 ログインするユーザはwheelグループに所属している必要があります。
 （インストール時のユーザ作成で「このユーザーを管理者にする」 をチェックしておけばOKです）

## 実行方法

```
ansible-playbook -i ./inventory/hosts redmine.yml
```

## 注意点
CentOS7 標準のsvnクライアントはバージョンが古く証明書エラーに対応できないため、以下のいずれかの対応が必要です。

- redmine.repo_url を http://～にする
- OS標準ではない svnクライアントをインストールする

