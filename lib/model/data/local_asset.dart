import 'package:flutter/material.dart';
import 'package:fun_refresh/tools/pic_tool.dart';

import '../smash_model.dart';

get navIcons => [
      ['$iconUri/news0.svg', '$iconUri/news1.svg'],
      ['$iconUri/video0.svg', '$iconUri/video1.svg'],
      ['$iconUri/extension0.svg', '$iconUri/extension1.svg'],
      ['$iconUri/chat0.svg', '$iconUri/chat1.svg']
    ];
get coverTitles => [
      '贪吃蛇',
      '数独',
      '俄罗斯方块',
      '开心消消乐',
      '颜值测算',
      '天气',
      '记事本',
      '美女',
    ];
get covers => [
      '',
      '',
    ];

get newsKey => [
      'd4005be8d8a8b05101c535b5b6fc053c',
      '3a86f36bd3ecac8a51135ded5eebe862',
      'd5a64087fc098f164e1dadf1b3550597',
      'eb0de04775958fb7ccb8934a9a0cda25',
      '925021c32be17cac549273a63f0d02be',
      '790004a13a863058bf989cfdf470fda9',
      'dccc69127dc757cb085337af2be35101',
      '925021c32be17cac549273a63f0d02be',
      '315a54463602e8f87c8aa4b3a817bf84',
      '9511527996051d8f659603e06b7712a0',
      'cc9de92b2c3f3517fd2f5a2a566ba2f1',
      '78a4734bfa5c052273531e412d5b359f',
      '530d98e8f59f3ab48e9bf335e39b760f',
      '93ff5c6fd6dc134fc69f6ffe3bc568a6',
      '483294d5e9b2202317817d0696b47a58',
      'a9f703a0200d68926f707f3f13629078',
      '173e0ec3e304227fa4564ecb246be0e5',
      '9c98897f8c0ef2f97ce13ef48f0c6cc1',
      '801f07aebfa84665f672e5dfb1df99ef',
      '989c40de0a1c5c3618f9469e8271f488',
      '6c9d043717499325c91fc1e9addd7d30',
      '5370d210dd038e9e4d722fd329a30130',
      '20f90a8cc49c35af597c877b3e55970d',
      '635bfc1b134d22fe67f08306a022e3c0',
      '93aa8c60492356f29d6fdf1a4a778556',
      '8e0af24653d32b64e6e2592ed000a76f',
      '87b359412c4e9ff628fafaf915f9f816',
      'a9f703a0200d68926f707f3f13629078',
      '6162ad447525a3402727f6398a8c3316',
      '3a86f36bd3ecac8a51135ded5eebe862',
      'fc35d7872c25744ab4669c7d9dbcf15e',
    ];
List<Choice> get choices => [
      Choice(title: '加好友', icon: Icons.person_add),
      Choice(title: '创建群', icon: Icons.people_outline),
    ];
