loadOrder.FILES['load-order.min.js'] = '''
  (function(){var e,r,t,i,l,o,s,d,a,n,h,p,c,u,g,m;a=Npm.require("path").basename,o=Npm.require("path").extname,p=Npm.require("path").join,c=Npm.require("path").resolve,t=Npm.require("fs").createReadStream,i=Npm.require("fs").createWriteStream,r=Npm.require("mkdirp").sync,l=Npm.require("rimraf").sync,s=Npm.require("glob").sync,this.loadOrder.helpers={pathResolve:c,getFilename:a,getAllFiles:s,deleteFolder:l,getExtension:function(e){return o(e).slice(1)},copyFile:function(e,l){return r(l),t(e).pipe(i(p(l,a(e))))}},d=this.loadOrder.helpers.getExtension,a=this.loadOrder.helpers.getFilename,e=this.loadOrder.helpers.copyFile,c=this.loadOrder.helpers.pathResolve,m=this.loadOrder.config.targetFolder,h=this.loadOrder.config.getLocus,n=this.loadOrder.config.getLoadOrderIndex,this.loadOrder.processFile=function(r){var t,i;return i=a(r),t=d(r),e(r,c(m,h(r,i,t),String(n(r,i,t))))},s=this.loadOrder.helpers.getAllFiles,l=this.loadOrder.helpers.deleteFolder,g=this.loadOrder.config.sourceFolder,m=this.loadOrder.config.targetFolder,u=this.loadOrder.processFile,l(m),s(g+"/**/*.*").forEach(u)}).call(this);

  '''
