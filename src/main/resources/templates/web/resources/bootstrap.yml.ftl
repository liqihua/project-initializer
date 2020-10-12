#apollo配置
app:
  id: ${projectName}

#让apollo在bootstrap阶段加载配置，否则默认application阶段，@ConditionalOnProperty无法读取
apollo:
  bootstrap:
    enabled: true