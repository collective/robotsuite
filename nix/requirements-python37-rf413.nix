# Generated by pip2nix 0.8.0.dev1
# See https://github.com/nix-community/pip2nix

{ pkgs, fetchurl, fetchgit, fetchhg }:

self: super: {
  "lxml" = super.buildPythonPackage rec {
    pname = "lxml";
    version = "4.8.0";
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/3b/94/e2b1b3bad91d15526c7e38918795883cee18b93f6785ea8ecf13f8ffa01e/lxml-4.8.0.tar.gz";
      sha256 = "08vf1kaqi1l2zcfks0bmwqybvq9miwi2ibmbm568l8p6c3y64gzn";
    };
    format = "setuptools";
    doCheck = false;
    buildInputs = [];
    checkInputs = [];
    nativeBuildInputs = [];
    propagatedBuildInputs = [];
  };
  "robotframework" = super.buildPythonPackage rec {
    pname = "robotframework";
    version = "4.1.3";
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/c0/70/e48e0d3ebdfb81920875f6b288c5b3e593cb9ca479377b11a46df5228567/robotframework-4.1.3-py2.py3-none-any.whl";
      sha256 = "1h4xxwynmigck27pnsw7whjx1xr8kks22a99fb9pi8s0nvjjbh06";
    };
    format = "wheel";
    doCheck = false;
    buildInputs = [];
    checkInputs = [];
    nativeBuildInputs = [];
    propagatedBuildInputs = [];
  };
  "six" = super.buildPythonPackage rec {
    pname = "six";
    version = "1.16.0";
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/d9/5a/e7c31adbe875f2abbb91bd84cf2dc52d792b5a01506781dbcf25c91daf11/six-1.16.0-py2.py3-none-any.whl";
      sha256 = "0m02dsi8lvrjf4bi20ab6lm7rr6krz7pg6lzk3xjs2l9hqfjzfwa";
    };
    format = "wheel";
    doCheck = false;
    buildInputs = [];
    checkInputs = [];
    nativeBuildInputs = [];
    propagatedBuildInputs = [];
  };
  "zc.buildout" = super.buildPythonPackage rec {
    pname = "zc.buildout";
    version = "2.13.7";
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/8b/48/2e0bca92a331d262ea13a232d161f4e11c6ad5dd63f632c500a207a61334/zc.buildout-2.13.7-py2.py3-none-any.whl";
      sha256 = "1r95skki6xn30q87m754yl6imzfnfhvz71sh5jh48q74lakin5q4";
    };
    format = "wheel";
    doCheck = false;
    buildInputs = [];
    checkInputs = [];
    nativeBuildInputs = [];
    propagatedBuildInputs = [
      self."setuptools"
    ];
  };
  "zc.recipe.egg" = super.buildPythonPackage rec {
    pname = "zc.recipe.egg";
    version = "2.0.7";
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/7a/6f/c6871e8490a153c3b44ac43e4a6552d802561a12b4780c7ea088a7ec5ff0/zc.recipe.egg-2.0.7.tar.gz";
      sha256 = "1lz6yjavc7s01bqfn11sk05x0i935cbk312fpf23akk1g44v17mq";
    };
    format = "setuptools";
    doCheck = false;
    buildInputs = [];
    checkInputs = [];
    nativeBuildInputs = [];
    propagatedBuildInputs = [
      self."setuptools"
      self."zc.buildout"
    ];
  };
  "zc.recipe.testrunner" = super.buildPythonPackage rec {
    pname = "zc.recipe.testrunner";
    version = "2.2";
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/74/09/9207fce4ae30d36272fa6d32637862646855594904f00c0097c24cd2d83b/zc.recipe.testrunner-2.2-py2.py3-none-any.whl";
      sha256 = "1x0j1r8b9chkp36m2ddpa1azdkspadp066yjw64wbnwqah105819";
    };
    format = "wheel";
    doCheck = false;
    buildInputs = [];
    checkInputs = [];
    nativeBuildInputs = [];
    propagatedBuildInputs = [
      self."setuptools"
      self."zc.buildout"
      self."zc.recipe.egg"
      self."zope.testrunner"
    ];
  };
  "zope.exceptions" = super.buildPythonPackage rec {
    pname = "zope.exceptions";
    version = "4.5";
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/0a/02/9a168c4fd798fbfcebbbef49065b0b6fb9c125a98cff7c6f1fbedc484b97/zope.exceptions-4.5-py2.py3-none-any.whl";
      sha256 = "1r7rc7cym41d96kipfqqfmgp1r3dvxb5sqcmyywgzq7b5pzpkpsz";
    };
    format = "wheel";
    doCheck = false;
    buildInputs = [];
    checkInputs = [];
    nativeBuildInputs = [];
    propagatedBuildInputs = [
      self."setuptools"
      self."zope.interface"
    ];
  };
  "zope.interface" = super.buildPythonPackage rec {
    pname = "zope.interface";
    version = "5.4.0";
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/ae/58/e0877f58daa69126a5fb325d6df92b20b77431cd281e189c5ec42b722f58/zope.interface-5.4.0.tar.gz";
      sha256 = "03jsiad578392pfmxa1ihkmvdh2q3dcwqy1vv240jgzc1x9mzfjx";
    };
    format = "setuptools";
    doCheck = false;
    buildInputs = [];
    checkInputs = [];
    nativeBuildInputs = [];
    propagatedBuildInputs = [
      self."setuptools"
    ];
  };
  "zope.testrunner" = super.buildPythonPackage rec {
    pname = "zope.testrunner";
    version = "5.4.0";
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/57/c3/ed2a94bbb2d08bf8e1aa2cc1c712994bf18146e37d41682ab42c442b478f/zope.testrunner-5.4.0-py2.py3-none-any.whl";
      sha256 = "11rcqca6l0qgnzascbh91rgcpfspv0aj30vj4d4q6q53cawbwzxf";
    };
    format = "wheel";
    doCheck = false;
    buildInputs = [];
    checkInputs = [];
    nativeBuildInputs = [];
    propagatedBuildInputs = [
      self."setuptools"
      self."six"
      self."zope.exceptions"
      self."zope.interface"
    ];
  };
}
