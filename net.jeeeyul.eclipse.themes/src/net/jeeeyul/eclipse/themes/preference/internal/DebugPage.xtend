package net.jeeeyul.eclipse.themes.preference.internal

import net.jeeeyul.eclipse.themes.preference.internal.JTPUtil
import net.jeeeyul.eclipse.themes.preference.internal.PreperencePageHelper
import net.jeeeyul.eclipse.themes.rendering.JTabSettings
import net.jeeeyul.swtend.SWTExtensions
import org.eclipse.swt.SWT
import org.eclipse.swt.custom.CTabFolder
import org.eclipse.swt.widgets.Composite
import org.eclipse.swt.widgets.Text
import org.eclipse.jface.preference.PreferenceStore

class DebugPage extends AbstractJTPreferencePage {
	Text epfView

	new() {
		super("Debug")
	}

	override createContents(Composite parent, extension SWTExtensions swtExtensions, extension PreperencePageHelper helper) {
		parent.newComposite [
			layout = newGridLayout
			epfView = newText(SWT.MULTI || SWT.V_SCROLL || SWT.H_SCROLL) [
				it.text = "Empty"
				layoutData = FILL_BOTH[
					widthHint = 200
					heightHint = 200
				]
			]
		]
	}

	override updatePreview(CTabFolder folder, JTabSettings renderSettings, extension SWTExtensions swtExtensions, extension PreperencePageHelper helper) {
		var fakeStore = new net.jeeeyul.eclipse.themes.preference.JThemePreferenceStore(new PreferenceStore ( ) )
		rootPage.saveTo(fakeStore)

		epfView.text = '''
			«FOR key : JTPUtil.listPreferenceKeys»
				«key»=«JTPUtil.saveConvert(fakeStore.getString(key), false, true)»
			«ENDFOR»
		'''
	}

	override load(net.jeeeyul.eclipse.themes.preference.JThemePreferenceStore store, extension SWTExtensions swtExtensions, extension PreperencePageHelper helper) {
	}

	override save(net.jeeeyul.eclipse.themes.preference.JThemePreferenceStore store, extension SWTExtensions swtExtensions, extension PreperencePageHelper helper) {
	}

	override dispose(extension SWTExtensions swtExtensions, extension PreperencePageHelper helper) {
	}

}